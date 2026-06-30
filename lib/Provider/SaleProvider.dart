import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Modal/SalesModel.dart';
import '../StateClass/SalesState.dart';


class SaleNotifier extends StateNotifier<SaleState> {

  SaleNotifier() : super(SaleState());

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;
  Stream<List<SaleModel>> getSales() {

    return firestore
        .collection("sales")
        .orderBy("date", descending: true)
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return SaleModel.fromMap(doc.data());

      }).toList();

    });

  }

}
final saleProvider =
StateNotifierProvider<SaleNotifier, SaleState>(
      (ref) => SaleNotifier(),
);

final saleStreamProvider =
StreamProvider<List<SaleModel>>(
      (ref) {
    return ref
        .read(saleProvider.notifier)
        .getSales();
  },
);