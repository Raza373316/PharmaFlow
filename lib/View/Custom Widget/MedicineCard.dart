import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomButton.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';

class Medicinecard extends StatefulWidget {
  final String name;
  final int stock;
  final int price;

  const Medicinecard({
    super.key,
    required this.name,
    required this.stock,
    required this.price,
  });

  @override
  State<Medicinecard> createState() => _MedicinecardState();
}

class _MedicinecardState extends State<Medicinecard> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [

            /// Medicine Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.name,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),

                  const SizedBox(height: 4),

                  CustomText(
                    text:
                    "Rs ${widget.price}  |  Stock ${widget.stock}",
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            /// Minus Button
            SizedBox(
              width: 35,
              height: 35,
              child: CustomButton(
                text: "-",

                fontsize: 14,
                borderRadius: 8,
                onPressed: () {
                  setState(() {
                    if (count > 0) {
                      count--;
                    }
                  });
                },
              ),
            ),

            const SizedBox(width: 10),

            /// Count Text
            CustomText(
              text: count.toString(),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(width: 10),

            /// Plus Button
            SizedBox(
              width: 35,
              height: 35,
              child: CustomButton(
                textColor: Colors.white,
                text: "+",
                fontsize: 14,
                borderRadius: 8,
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}