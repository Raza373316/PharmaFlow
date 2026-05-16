import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';

import '../Custom Widget/MedicineCard.dart';

class Billingscreen extends StatefulWidget {
  const Billingscreen({super.key});

  @override
  State<Billingscreen> createState() => _BillingscreenState();
}

class _BillingscreenState extends State<Billingscreen> {
  TextEditingController search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Bill",),
        backgroundColor: Colors.blue,
      ),backgroundColor: Colors.lightBlue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
             children: [
               SizedBox(height: 5,),
               CustomTextField(controller: search, hintText: 'Search',prefixIcon: Icons.search,
               ),
               Container(
                 margin: EdgeInsets.all(5),
                 padding: EdgeInsets.all(10),
                 width: double.infinity,
                 height: 150,
                 decoration: BoxDecoration(
                   color: Colors.white70,
                   borderRadius: BorderRadius.circular(8),
                   boxShadow: [
                     BoxShadow(
                       offset: Offset(2, 2),
                       blurRadius: 4,
                       color: Colors.black,
                     ),
                   ],
                 ),
                 child: ListView(
                   children: [
                     Medicinecard(name: "saas", stock: 29, price: 100),
                     Medicinecard(name: "saas", stock: 29, price: 100),
                   ],
                 )
               ),
               ],
        ),
      ),
    );
  }
}
