import '../Modal/MedicineModel.dart';

class MedicineState {
  final bool isLoading;
  final List<MedicineModel> medicines;
  final String? error;

  MedicineState({
    this.isLoading = false,
    this.medicines = const [],
    this.error,
  });

  MedicineState copyWith({
    bool? isLoading,
    List<MedicineModel>? medicines,
    String? error,
  }) {
    return MedicineState(
      isLoading: isLoading ?? this.isLoading,
      medicines: medicines ?? this.medicines,
      error: error,
    );
  }
}