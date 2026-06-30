import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacymanagement/Modal/SalesModel.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';

import '../../Provider/SaleProvider.dart';
import 'Invoice_details_screen.dart';

class SalesHistoryScreen extends ConsumerStatefulWidget {
  const SalesHistoryScreen({super.key});

  @override
  ConsumerState<SalesHistoryScreen> createState() => _SalesHistoryScreenState();
}

class _SalesHistoryScreenState extends ConsumerState<SalesHistoryScreen> {
  TextEditingController searchController = TextEditingController();

  // Sample sales data


  @override
  Widget build(BuildContext context) {
    final sales = ref.watch(saleStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Sales History',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      backgroundColor: Colors.lightBlue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 5),

            // Search Bar
            CustomTextField(
              controller: searchController,
              hintText: 'Search Invoice',
              prefixIcon: Icons.search,
            ),

            SizedBox(height: 16),

            // Sales List
            Expanded(
              child: sales.when(

                loading: () =>
                const Center(
                  child: CircularProgressIndicator(),
                ),

                error: (e, _) =>
                    Center(
                      child: Text(e.toString()),
                    ),

                data: (saleList) {

                  if (saleList.isEmpty) {
                    return const Center(
                      child: Text("No Sales Found"),
                    );
                  }

                  return ListView.builder(

                    itemCount: saleList.length,

                    itemBuilder: (context, index) {

                      final sale = saleList[index];

                      return _buildInvoiceCard(context, sale);

                    },
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
//---------------------invoice card
  Widget _buildInvoiceCard(BuildContext context, SaleModel sale) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvoiceDetailScreen(sale: sale),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 6,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invoice Number
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Invoice #${sale.id}",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),

            SizedBox(height: 10),

            Divider(color: Colors.grey.shade300, height: 1),

            SizedBox(height: 10),

            // Date, Items, Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "${sale.date.toString()}",
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text: "${sale.items.length} Items",
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                CustomText(
                  text: "Rs. ${sale.total}",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
