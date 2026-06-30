class MedicineModel {
  final String id;
  final String name;

  final int stock;
  final double purchasePrice;
  final double sellPrice;

  final String category; // tablet, syrup, capsule, injection
  final String company;

  final String expiryDate;

  MedicineModel({
    required this.id,
    required this.name,
    required this.stock,
    required this.purchasePrice,
    required this.sellPrice,
    required this.category,
    required this.company,
    required this.expiryDate,
  });

  MedicineModel copyWith({
    String? id,
    String? name,
    int? stock,
    double? purchasePrice,
    double? sellPrice,
    String? category,
    String? company,
    String? expiryDate,
  }) {
    return MedicineModel(
      id: id ?? this.id,
      name: name ?? this.name,
      stock: stock ?? this.stock,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellPrice: sellPrice ?? this.sellPrice,
      category: category ?? this.category,
      company: company ?? this.company,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "stock": stock,
      "purchasePrice": purchasePrice,
      "sellPrice": sellPrice,
      "category": category,
      "company": company,
      "expiryDate": expiryDate,
    };
  }

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      stock: map["stock"] ?? 0,
      purchasePrice: (map["purchasePrice"] ?? 0).toDouble(),
      sellPrice: (map["sellPrice"] ?? 0).toDouble(),
      category: map["category"] ?? "",
      company: map["company"] ?? "",
      expiryDate: map["expiryDate"] ?? "",
    );
  }
}