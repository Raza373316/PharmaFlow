import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacymanagement/View/AppScreens/MainScreenNavigation.dart';
import 'package:pharmacymanagement/View/AppScreens/Search%20Medicine.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomButton.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';

import '../../Modal/MedicineModel.dart';
import '../../Provider/MedicineProvider.dart';

class Addmedicine extends ConsumerStatefulWidget {
  const Addmedicine({super.key});

  @override
  ConsumerState<Addmedicine> createState() => _AddmedicineState();
}

class _AddmedicineState extends ConsumerState<Addmedicine> {
  TextEditingController medicinename = TextEditingController();
  TextEditingController catergory = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController purchaseprice = TextEditingController();
  TextEditingController sellingprice = TextEditingController();
  TextEditingController stockquantity = TextEditingController();
  TextEditingController expirydate = TextEditingController();
  final List<String> categories = [
    "Tablet",
    "Syrup",
    "Capsule",
    "Injection",
    "Spray",
  ];
  String? selectedCategory;


  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().day+100),
      lastDate: DateTime(DateTime.now().year+7),
    );

    if (pickedDate != null) {
      controller.text =
      pickedDate.toIso8601String().split("T")[0];
      //"${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
    }
  }

    @override

  Widget build(BuildContext context) {
    final medicineState = ref.watch(medicineProvider);
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
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                hintText: "Select Category",

                filled: true,
                fillColor: Colors.grey.shade100,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),

                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                ),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
               SizedBox(height: 10),
              CustomText(text: "Company", color: Colors.white),

              SizedBox(height: 5),
              CustomTextField(controller: company, hintText: "Company"),
              SizedBox(height: 10),
              CustomText(text: "Purchase Price", color: Colors.white),

              SizedBox(height: 5),
              CustomTextField(controller: purchaseprice, hintText: "100Pkr",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // For integers (e.g., 10, 20)

                ],),
              SizedBox(height: 10),
              CustomText(text: "Selling Price", color: Colors.white),

              SizedBox(height: 5),
              CustomTextField(controller: sellingprice, hintText: "120",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // For integers (e.g., 10, 20)

                ],
              ),
              SizedBox(height: 10),
              CustomText(text: "Stock Quantity", color: Colors.white),

              SizedBox(height: 5),
              CustomTextField(controller: stockquantity, hintText: "50",
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // For integers (e.g., 10, 20)

              ],),
              SizedBox(height: 10),
              CustomText(text: "Expiry Date", color: Colors.white),

              SizedBox(height: 5),
              CustomTextField(controller: expirydate,
                  onTap:(){
                _selectDate(expirydate);
                  },hintText: "dd/mm/yyyy"),
              SizedBox(height: 20),
              CustomButton(
                text: 'Save Medicine',
                height: 40,
                isLoading: medicineState.isLoading,
                onPressed: () async {
                  if (medicinename.text.isEmpty ||
                      stockquantity.text.isEmpty ||
                      purchaseprice.text.isEmpty ||
                      company.text.isEmpty ||
                      expirydate.text.isEmpty ||
                      sellingprice.text.isEmpty ||
                      catergory.text==null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }
                  final medicineId = DateTime.now().millisecondsSinceEpoch
                      .toString();

                  final medicine = MedicineModel(
                    id: medicineId,
                    name: medicinename.text.trim(),
                    stock: int.parse(stockquantity.text.trim()),
                    purchasePrice: double.parse(purchaseprice.text.trim()),
                    sellPrice: double.parse(sellingprice.text.trim()),
                    category: catergory.text.trim(),
                    company: company.text.trim(),
                    expiryDate: expirydate.text,
                  );

                  await ref
                      .read(medicineProvider.notifier)
                      .addMedicine(medicine);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Add medecine sucesfully")),

                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MainNavigationScreen(initialIndex: 1,)));
                },
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
