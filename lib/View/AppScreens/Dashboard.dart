import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomButton.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/auth/LoginScreen.dart';

import '../Custom Widget/CustomTextField.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "PharmaFlow",fontWeight: FontWeight.bold,),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.lightBlue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            CustomTextField(
              controller: search,
              hintText: "Search",
              prefixIcon: Icons.search,
              onTap: () {},
              backgroundcolor: Colors.blue.shade100,
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    icon: Icons.money,
                    label: "Total sales today",
                    value: "25500 pkr",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _infoCard(
                    icon: Icons.countertops_rounded,
                    label: "Low Stock Items",
                    value: "21",
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    icon: Icons.event_busy,
                    label: "Expiry Soon",
                    value: "5",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _infoCard(
                    icon: Icons.dashboard,
                    label: "Total Items",
                    value: "321",
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomText(
              text: "Quick Action",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Add Medicne",
                    icon: Icons.medication,height: 40,
                    fontsize: 12,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: CustomButton(
                    text: "Create Bill",
                    height: 40,
                    icon: Icons.receipt_long,
                    fontsize: 12,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoCard({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white60,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 6),
            Expanded(child: CustomText(text: label, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 10),
        CustomText(text: value,fontSize: 22,fontWeight: FontWeight.bold,),
      ],
    ),
  );
}
