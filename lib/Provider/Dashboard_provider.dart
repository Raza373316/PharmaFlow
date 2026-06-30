import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../StateClass/DashboadState.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier() : super(DashboardState());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> fetchDashboardData() async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      // =========================
      // 1. MEDICINES COLLECTION
      // =========================
      final medicineSnapshot =
      await firestore.collection("medicines").get();

      final medicines = medicineSnapshot.docs;

      int totalMedicines = 0;
      int lowStock = 0;
      int expirySoon = 0;

      final now = DateTime.now();
      final thirtyDaysFromNow = now.add(const Duration(days: 30));

      for (var doc in medicines) {
        final data = doc.data();

        final stock = (data["stock"] ?? 0) as int;

        // Ignore medicines whose stock is 0
        if (stock <= 0) continue;

        totalMedicines++;

        // ---------- LOW STOCK ----------
        if (stock <= 10) {
          lowStock++;
        }

        // ---------- EXPIRY ----------
        try {
          final expiryDate = DateTime.parse(data["expiryDate"]);

          if (expiryDate.isBefore(thirtyDaysFromNow)) {
            expirySoon++;
          }
        } catch (e) {
          // Ignore invalid date
        }
      }

      // =========================
      // 2. SALES COLLECTION
      // =========================
      final salesSnapshot =
      await firestore.collection("sales").get();

      double totalSales = 0;

      for (var doc in salesSnapshot.docs) {
        final data = doc.data();

        totalSales += (data["total"] ?? 0).toDouble();
      }

      // =========================
      // UPDATE STATE
      // =========================
      state = state.copyWith(
        isLoading: false,
        totalMedicines: totalMedicines,
        lowStockMedicines: lowStock,
        expiryMedicines: expirySoon,
        todaySales: totalSales,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}final dashboardProvider =
StateNotifierProvider<DashboardNotifier, DashboardState>(
      (ref) => DashboardNotifier(),
);