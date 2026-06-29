import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Modal/BillItemModel.dart';
import '../Modal/MedicineModel.dart';
import '../StateClass/BillState.dart';

class BillingNotifier extends StateNotifier<BillingState> {
  BillingNotifier() : super(BillingState());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Add Medicine

  void addToCart(MedicineModel medicine) {
    final index = state.cartItems.indexWhere(
      (item) => item.medicine.id == medicine.id,
    );

    if (index != -1) {
      final updated = [...state.cartItems];

      final item = updated[index];

      updated[index] = item.copyWith(quantity: item.quantity + 1);

      state = state.copyWith(cartItems: updated);
    } else {
      state = state.copyWith(
        cartItems: [
          ...state.cartItems,

          BillItemModel(medicine: medicine, quantity: 1),
        ],
      );
    }
  }

  /// Increase

  void increaseQuantity(String medicineId) {
    final updated = state.cartItems.map((item) {
      if (item.medicine.id == medicineId) {
        return item.copyWith(quantity: item.quantity + 1);
      }

      return item;
    }).toList();

    state = state.copyWith(cartItems: updated);
  }

  /// Decrease

  void decreaseQuantity(String medicineId) {
    List<BillItemModel> updated = [];

    for (var item in state.cartItems) {
      if (item.medicine.id == medicineId) {
        if (item.quantity > 1) {
          updated.add(item.copyWith(quantity: item.quantity - 1));
        }
      } else {
        updated.add(item);
      }
    }

    state = state.copyWith(cartItems: updated);
  }

  /// Remove

  void removeItem(String medicineId) {
    state = state.copyWith(
      cartItems: state.cartItems
          .where((item) => item.medicine.id != medicineId)
          .toList(),
    );
  }

  ///////Save sale
  Future<void> saveSale() async {
    if (state.cartItems.isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final saleId = DateTime.now().millisecondsSinceEpoch.toString();
      List<Map<String, dynamic>> items = [];
      for (var item in state.cartItems) {
        items.add({
          "medicineId": item.medicine.id,

          "name": item.medicine.name,

          "price": item.medicine.sellPrice,

          "quantity": item.quantity,

          "subtotal": item.subtotal,
        });
      }
      final testDoc = await firestore
          .collection("medicines")
          .doc(state.cartItems.first.medicine.id)
          .get();

      print("Outside Transaction Exists: ${testDoc.exists}");
      print("Outside Transaction Data: ${testDoc.data()}");
      await firestore.runTransaction((transaction) async {

        final saleRef = firestore.collection("sales").doc(saleId);

        List<DocumentSnapshot<Map<String, dynamic>>> snapshots = [];

        // STEP 1 : READ EVERYTHING
        for (var item in state.cartItems) {
          final medicineRef =
          firestore.collection("medicines").doc(item.medicine.id);

          final snapshot = await transaction.get(medicineRef);

          if (!snapshot.exists) {
            throw Exception("Medicine not found");
          }

          snapshots.add(snapshot);
        }

        // STEP 2 : UPDATE STOCK
        for (int i = 0; i < state.cartItems.length; i++) {
          final item = state.cartItems[i];
          final snapshot = snapshots[i];

          final currentStock = (snapshot["stock"] as num).toInt();

          if (currentStock < item.quantity) {
            throw Exception("Insufficient stock");
          }

          transaction.update(
            snapshot.reference,
            {
              "stock": currentStock - item.quantity,
            },
          );
        }

        // STEP 3 : SAVE SALE
        transaction.set(saleRef, {
          "id": saleId,
          "date": Timestamp.now(),
          "total": state.total,
          "items": items,

        });

      });

      state = state.copyWith(cartItems: []);
      state = state.copyWith(isLoading: false);
    } catch (e, stackTrace) {
      print("ERROR: $e");
      print(stackTrace);

      state = state.copyWith(isLoading: false, error: e.toString());

      rethrow;
    }
  }

  /// Clear

  void clearCart() {
    state = BillingState();
  }
}

final billingProvider = StateNotifierProvider<BillingNotifier, BillingState>(
  (ref) => BillingNotifier(),
);
