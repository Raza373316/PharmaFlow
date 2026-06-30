
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Modal/SalesModel.dart';
import '../Custom Widget/CustomText.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final SaleModel sale;

  const InvoiceDetailScreen({
    super.key,
    required this.sale,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Invoice #${sale.id}',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.lightBlue.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),

              // Invoice Header Card
              Container(
                padding: EdgeInsets.all(16),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Invoice #${sale.id}",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            SizedBox(height: 6),
                            CustomText(
                              text: "Date",
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            CustomText(
                              text: "${sale.date.toString()}",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomText(
                            text: "Completed",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Items Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomText(
                  text: "Items",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 8),

              // Items List
              Container(
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
                  children: List.generate(
                    sale.items.length,
                        (index) {
                      var item = sale.items[index];
                      return _buildItemRow(item, index, sale.items.length);
                    },
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Total Card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: "Total",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    SizedBox(height: 8),
                    CustomText(
                      text: "Rs.${sale.total}",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(
      Map<String, dynamic> item,
      int index,
      int totalItems,
      ) {
    bool isLast = index == totalItems - 1;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: item["name"],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text: "${item["quantity"]} × ${item["price"]} = ${item["quantity"]*item['price']}",
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
              CustomText(
                text: "Rs. ${item["quantity"]*item['price']}",
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            color: Colors.grey.shade200,
            indent: 14,
            endIndent: 14,
          ),
      ],
    );
  }
}
