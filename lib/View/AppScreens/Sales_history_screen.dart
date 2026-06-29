import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';

import 'Invoice_details_screen.dart';

class SalesHistoryScreen extends StatefulWidget {
  const SalesHistoryScreen({super.key});

  @override
  State<SalesHistoryScreen> createState() => _SalesHistoryScreenState();
}

class _SalesHistoryScreenState extends State<SalesHistoryScreen> {
  TextEditingController searchController = TextEditingController();

  // Sample sales data
  final List<Map<String, dynamic>> salesHistory = [
    {
      "invoiceNumber": "1001",
      "date": "28 Jun 2026",
      "itemCount": 3,
      "totalAmount": 1450,
      "items": [
        {"name": "Panadol", "quantity": 2, "price": 120, "total": 240},
        {"name": "Augmentin", "quantity": 1, "price": 450, "total": 450},
        {"name": "Brufen", "quantity": 3, "price": 250, "total": 750},
      ]
    },
    {
      "invoiceNumber": "1002",
      "date": "28 Jun 2026",
      "itemCount": 2,
      "totalAmount": 750,
      "items": [
        {"name": "Calpol", "quantity": 2, "price": 200, "total": 400},
        {"name": "Aspirin", "quantity": 1, "price": 350, "total": 350},
      ]
    },
    {
      "invoiceNumber": "1003",
      "date": "27 Jun 2026",
      "itemCount": 5,
      "totalAmount": 3900,
      "items": [
        {"name": "Ibuprofen", "quantity": 2, "price": 150, "total": 300},
        {"name": "Vitamin C", "quantity": 3, "price": 200, "total": 600},
        {"name": "Amoxicillin", "quantity": 1, "price": 500, "total": 500},
        {"name": "Augmentin", "quantity": 2, "price": 400, "total": 800},
        {"name": "Brufen", "quantity": 2, "price": 350, "total": 700},
      ]
    },
    {
      "invoiceNumber": "1004",
      "date": "26 Jun 2026",
      "itemCount": 4,
      "totalAmount": 2200,
      "items": [
        {"name": "Panadol", "quantity": 3, "price": 120, "total": 360},
        {"name": "Calpol", "quantity": 1, "price": 200, "total": 200},
        {"name": "Brufen", "quantity": 2, "price": 250, "total": 500},
        {"name": "Aspirin", "quantity": 2, "price": 350, "total": 700},
      ]
    },
    {
      "invoiceNumber": "1005",
      "date": "25 Jun 2026",
      "itemCount": 3,
      "totalAmount": 1800,
      "items": [
        {"name": "Vitamin C", "quantity": 4, "price": 200, "total": 800},
        {"name": "Panadol", "quantity": 2, "price": 120, "total": 240},
        {"name": "Calpol", "quantity": 2, "price": 200, "total": 400},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                itemCount: salesHistory.length,
                itemBuilder: (context, index) {
                  var sale = salesHistory[index];
                  return _buildInvoiceCard(context, sale);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
//---------------------invoice card
  Widget _buildInvoiceCard(BuildContext context, Map<String, dynamic> sale) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvoiceDetailScreen(invoiceData: sale),
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
                  text: "Invoice #${sale["invoiceNumber"]}",
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
                      text: "${sale["date"]}",
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text: "${sale["itemCount"]} Items",
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                CustomText(
                  text: "Rs. ${sale["totalAmount"]}",
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
