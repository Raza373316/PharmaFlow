import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomButton.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';

class Addmedicine extends StatefulWidget {
  const Addmedicine({super.key});

  @override
  State<Addmedicine> createState() => _AddmedicineState();
}

class _AddmedicineState extends State<Addmedicine> {
  TextEditingController medicinename = TextEditingController();
  TextEditingController catergory = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController purchaseprice = TextEditingController();
  TextEditingController sellingprice = TextEditingController();
  TextEditingController stockquantity = TextEditingController();
  TextEditingController expirydate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Add Medicine", fontWeight: FontWeight.bold),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.lightBlue.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Add Medicine", color: Colors.white),
        
              SizedBox(height: 5),
              CustomTextField(
                controller: medicinename,
                hintText: "Medicine Name",
              ),
              SizedBox(height: 10),
              CustomText(text: "Category", color: Colors.white),
        
              SizedBox(height: 5),
              CustomTextField(
                controller: catergory,
                hintText: "Medicine Name",
              ),
              SizedBox(height: 10),
              CustomText(text: "Company", color: Colors.white),
        
              SizedBox(height: 5),
              CustomTextField(
                controller: company,
                hintText: "Company",
              ),
              SizedBox(height: 10),
              CustomText(text: "Purchase Price", color: Colors.white),
        
              SizedBox(height: 5),
              CustomTextField(
                controller: purchaseprice,
                hintText: "100Pkr",
              ),
              SizedBox(height: 10),
              CustomText(text: "Selling Price", color: Colors.white),
        
              SizedBox(height: 5),
              CustomTextField(
                controller: sellingprice,
                hintText: "120",
              ),
              SizedBox(height: 10),
              CustomText(text: "Stock Quantity", color: Colors.white),
        
              SizedBox(height: 5),
              CustomTextField(
                controller:stockquantity,
                hintText: "50",
              ),
              SizedBox(height: 10),
              CustomText(text: "Expiry Date", color: Colors.white),
        
              SizedBox(height: 5),
              CustomTextField(
                controller:expirydate,
                hintText: "dd/mm/yyyy",
              ),
              SizedBox(height: 20,),
              CustomButton(text: 'Save Medicine',height: 40, onPressed: (){}),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
