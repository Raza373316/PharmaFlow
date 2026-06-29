import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      id: map["id"] ?? "",

      date: (map["date"] as Timestamp).toDate(),

      total: (map["total"] as num).toDouble(),

      items: List<Map<String, dynamic>>.from(
        map["items"] ?? [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": Timestamp.fromDate(date),
      "total": total,
      "items": items,
    };
  }
}