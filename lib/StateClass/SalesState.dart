
import '../Modal/SalesModel.dart';

class SaleState {

  final bool isLoading;

  final String? error;

  final List<SaleModel> sales;

  SaleState({
    this.isLoading = false,
    this.error,
    this.sales = const [],
  });

  SaleState copyWith({
    bool? isLoading,
    String? error,
    List<SaleModel>? sales,
  }) {
    return SaleState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sales: sales ?? this.sales,
    );
  }
}