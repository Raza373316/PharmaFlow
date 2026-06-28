class SaleModel {
  final String id;
  final DateTime date;
  final double total;
  final List<Map<String, dynamic>> items;

  SaleModel({
    required this.id,
    required this.date,
    required this.total,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "total": total,
      "items": items,
    };
  }
}