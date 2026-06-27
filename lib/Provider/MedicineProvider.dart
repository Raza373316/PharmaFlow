import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Modal/MedicineModel.dart';
import '../StateClass/MedicineState.dart';


class MedicineNotifier extends StateNotifier<MedicineState> {
  MedicineNotifier() : super(MedicineState());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ADD MEDICINE
  Future<void> addMedicine(MedicineModel medicine) async {
    try {
      state = state.copyWith(isLoading: true);

      await _firestore
          .collection("medicines")
          .doc(medicine.id)
          .set(medicine.toMap());
      print("MEDICINE SAVED SUCCESSFULLY");

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // FETCH MEDICINES (REAL TIME)
  Stream<List<MedicineModel>> getMedicines() {
    return _firestore.collection("medicines").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MedicineModel.fromMap(doc.data()))
          .toList();
    });
  }

  // DELETE MEDICINE
  Future<void> deleteMedicine(String id) async {
    await _firestore.collection("medicines").doc(id).delete();
  }
}

final medicineProvider =
StateNotifierProvider<MedicineNotifier, MedicineState>(
      (ref) => MedicineNotifier(),
);