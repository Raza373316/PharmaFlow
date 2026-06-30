import 'MedicineModel.dart';

class BillItemModel {
  final MedicineModel medicine;
  final int quantity;

  BillItemModel({
    required this.medicine,
    required this.quantity,
  });

  double get subtotal => medicine.sellPrice * quantity;

  BillItemModel copyWith({
    MedicineModel? medicine,
    int? quantity,
  }) {
    return BillItemModel(
      medicine: medicine ?? this.medicine,
      quantity: quantity ?? this.quantity,
    );
  }
}