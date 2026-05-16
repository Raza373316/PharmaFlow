import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';

class Medicinesearchcard extends StatefulWidget {
  final String Name;
  final String Status;
  final double  price;
  final String ExpiryDate;
  final int Stock;
  const Medicinesearchcard({super.key,


  required this.Name,
    required this.price,
    required this.Status,
  required this.ExpiryDate,
  required this.Stock});

  @override
  State<Medicinesearchcard> createState() => _MedicinesearchcardState();
}

class _MedicinesearchcardState extends State<Medicinesearchcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
margin: EdgeInsetsGeometry.all(5),
      padding: EdgeInsets.all(10),
      width: double.infinity,
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [

      Row(
        children: [
          CustomText(text: "Name",color: Colors.blueAccent,),
          SizedBox(width: 30,),
          CustomText(text: widget.Name),
          Spacer(),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.Status == 'pending'
                  ? Colors.orange
                  : widget.Status == 'Expiry'
                  ? Colors.red
                  : Colors.blue,
            ),
            child: CustomText(text: widget.Status, fontSize: 10),
          ),

        ],
      ),


         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [

             CustomText(text: "Price",color: Colors.blueAccent,),
             CustomText(text: widget.price.toString()),

             CustomText(text: "Stock",color: Colors.blueAccent,),
             CustomText(text: widget.Stock.toString()),
           ],
         ),
          CustomText(text: "Expiry",color: Colors.blueAccent,),
          CustomText(text: widget.ExpiryDate),

        ],
      ),
    );
  }
}
