import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Modal/BillItemModel.dart';
import '../Modal/MedicineModel.dart';
import '../StateClass/BillState.dart';


class BillingNotifier extends StateNotifier<BillingState> {

  BillingNotifier() : super(BillingState());

  /// Add Medicine

  void addToCart(MedicineModel medicine) {

    final index = state.cartItems.indexWhere(
            (item) => item.medicine.id == medicine.id);

    if (index != -1) {

      final updated = [...state.cartItems];

      final item = updated[index];

      updated[index] = item.copyWith(
        quantity: item.quantity + 1,
      );

      state = state.copyWith(
        cartItems: updated,
      );

    } else {

      state = state.copyWith(
        cartItems: [

          ...state.cartItems,

          BillItemModel(
            medicine: medicine,
            quantity: 1,
          )

        ],
      );

    }
  }

  /// Increase

  void increaseQuantity(String medicineId) {

    final updated = state.cartItems.map((item) {

      if (item.medicine.id == medicineId) {

        return item.copyWith(
          quantity: item.quantity + 1,
        );

      }

      return item;

    }).toList();

    state = state.copyWith(
      cartItems: updated,
    );
  }

  /// Decrease

  void decreaseQuantity(String medicineId) {

    List<BillItemModel> updated = [];

    for (var item in state.cartItems) {

      if (item.medicine.id == medicineId) {

        if (item.quantity > 1) {

          updated.add(
            item.copyWith(
              quantity: item.quantity - 1,
            ),
          );

        }

      } else {

        updated.add(item);

      }

    }

    state = state.copyWith(
      cartItems: updated,
    );
  }

  /// Remove

  void removeItem(String medicineId) {

    state = state.copyWith(

      cartItems: state.cartItems.where(

              (item) => item.medicine.id != medicineId

      ).toList(),

    );
  }

  /// Clear

  void clearCart() {

    state = BillingState();

  }

}

final billingProvider =
StateNotifierProvider<BillingNotifier, BillingState>(
        (ref) => BillingNotifier());