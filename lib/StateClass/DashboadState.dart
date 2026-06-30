class DashboardState {
  final bool isLoading;
  final String? error;

  final int totalMedicines;
  final int lowStockMedicines;
  final int expiryMedicines;
  final double todaySales;

  DashboardState({
    this.isLoading = false,
    this.error,
    this.totalMedicines = 0,
    this.lowStockMedicines = 0,
    this.expiryMedicines = 0,
    this.todaySales = 0,
  });

  DashboardState copyWith({
    bool? isLoading,
    String? error,
    int? totalMedicines,
    int? lowStockMedicines,
    int? expiryMedicines,
    double? todaySales,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      totalMedicines: totalMedicines ?? this.totalMedicines,
      lowStockMedicines: lowStockMedicines ?? this.lowStockMedicines,
      expiryMedicines: expiryMedicines ?? this.expiryMedicines,
      todaySales: todaySales ?? this.todaySales,
    );
  }
}