import '../Modal/BillItemModel.dart';

class BillingState {
  final List<BillItemModel> cartItems;
  final bool isLoading;
  final String? error;

  BillingState({
    this.cartItems = const [],
    this.isLoading = false,
    this.error,
  });

  double get total {

    double sum = 0;

    for (var item in cartItems) {
      sum += item.subtotal;
    }

    return sum;
  }

  BillingState copyWith({
    List<BillItemModel>? cartItems,
    bool? isLoading,
    String? error,
  }) {
    return BillingState(
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}