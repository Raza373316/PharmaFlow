// import 'package:flutter/material.dart';
// import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
// import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';
//
// import '../Custom Widget/MedicineCard.dart';
//
// class Billingscreen extends StatefulWidget {
//   const Billingscreen({super.key});
//
//   @override
//   State<Billingscreen> createState() => _BillingscreenState();
// }
//
// class _BillingscreenState extends State<Billingscreen> {
//   TextEditingController search=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: CustomText(text: "Bill",),
//         backgroundColor: Colors.blue,
//       ),backgroundColor: Colors.lightBlue.shade300,
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//              children: [
//                SizedBox(height: 5,),
//                CustomTextField(controller: search, hintText: 'Search',prefixIcon: Icons.search,
//                ),
//                Container(
//                  margin: EdgeInsets.all(5),
//                  padding: EdgeInsets.all(10),
//                  width: double.infinity,
//                  height: 150,
//                  decoration: BoxDecoration(
//                    color: Colors.white70,
//                    borderRadius: BorderRadius.circular(8),
//                    boxShadow: [
//                      BoxShadow(
//                        offset: Offset(2, 2),
//                        blurRadius: 4,
//                        color: Colors.black,
//                      ),
//                    ],
//                  ),
//                  child: ListView(
//                    children: [
//                      Medicinecard(name: "Pandol", stock: 29, price: 100),
//                      Medicinecard(name: "Campol", stock: 9, price: 170),
//                    ],
//                  )
//                ),
//                ],
//         ),
//       ),
//     );
//   }
// }
//---------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomButton.dart';

import '../../Provider/BillProvider.dart';
import '../../Provider/MedicineProvider.dart';


class Billingscreen extends ConsumerStatefulWidget {
  const Billingscreen({super.key});

  @override
  ConsumerState<Billingscreen> createState() => _BillingscreenState();
}

class _BillingscreenState extends ConsumerState<Billingscreen> {
  TextEditingController search = TextEditingController();
  String searchText = "";


  // Sample medicine list




  void printBill() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Print Bill - Coming Soon"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medicines = ref.watch(medicineStreamProvider);
    final billingState = ref.watch(billingProvider);
    final billingNotifier = ref.read(billingProvider.notifier);


    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Create Invoice", color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      backgroundColor: Colors.lightBlue.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 5),

              // Search Bar
              CustomTextField(
                controller: search,
                hintText: 'Search medicine',
                prefixIcon: Icons.search,
                onChanged:  (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
              ),

              SizedBox(height: 10),

              // Available Medicines Label
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Available Medicines",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 5),

              // Available Medicines Section
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
                      color: Colors.black26,
                    ),
                  ],
                ),
                child: medicines.when(

                  loading: () =>
                  const Center(child: CircularProgressIndicator()),

                  error: (e, _) =>
                      Center(child: Text(e.toString())),

                  data: (medicineList) {

                    final query = search.text.toLowerCase();

                    final filteredMedicines = medicineList.where((medicine) {

                      return medicine.stock > 0 &&
                          medicine.name.toLowerCase().contains(query);
                    }).toList();

                    filteredMedicines.sort((a, b) {
                      final aStarts = a.name.toLowerCase().startsWith(query);
                      final bStarts = b.name.toLowerCase().startsWith(query);

                      if (aStarts && !bStarts) return -1;
                      if (!aStarts && bStarts) return 1;

                      return a.name.compareTo(b.name);
                    });


                    return ListView.builder(

                      itemCount: filteredMedicines.length,

                      itemBuilder: (context, index) {

                        final medicine = filteredMedicines[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    CustomText(
                                      text: medicine.name,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    CustomText(
                                      text:
                                      "Rs.${medicine.sellPrice} | Stock : ${medicine.stock}",
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () {

                                  final message =
                                  billingNotifier.addToCart(medicine);

                                  if (message != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(message),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }

                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

              ),

              SizedBox(height: 15),

              // Bill Label
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Your Bill",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 5),

              // EXPANDED Bill Container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Bill Header
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "Medicine", fontSize: 12, fontWeight: FontWeight.bold),
                          CustomText(text: "Qty", fontSize: 12, fontWeight: FontWeight.bold),
                          CustomText(text: "Price", fontSize: 12, fontWeight: FontWeight.bold),
                          CustomText(text: "Total", fontSize: 12, fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),

                    // Cart Items List
                    Container(
                      constraints: BoxConstraints(minHeight: 100, maxHeight: 400),
                      child: billingState.cartItems.isEmpty
                          ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CustomText(
                            text: "No items in cart\nAdd medicines to see bill",
                            textAlign: TextAlign.center,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      )
                          : ListView.builder(
                        shrinkWrap: true,
                        itemCount: billingState.cartItems.length,
                        itemBuilder: (context, index) {
                          var item = billingState.cartItems[index];
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Medicine Name & Controls
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: item.medicine.name,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomText(
                                        text: "Rs.${item.medicine.sellPrice} each",
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 6),
                                      // Quantity controls
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red.shade100,
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            child: InkWell(
                                              onTap: () => billingNotifier.decreaseQuantity(
                                                item.medicine.id,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                child: Icon(Icons.remove, size: 14, color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            child: CustomText(
                                              text: "${item.quantity}",
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                final message =
                                                billingNotifier.increaseQuantity(item.medicine.id);

                                                if (message != null) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text(message),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                }

                                              },  child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                child: Icon(Icons.add, size: 14, color: Colors.green),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Qty Display
                                Expanded(
                                  flex: 1,
                                  child: CustomText(
                                    text: "${item.quantity}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                // Unit Price
                                Expanded(
                                  flex: 1,
                                  child: CustomText(
                                    text: "Rs.${item.medicine.sellPrice}",
                                    fontSize: 11,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                // Total Price
                                Expanded(
                                  flex: 1,
                                  child: CustomText(
                                    text: "Rs.${item.subtotal}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(width: 8),

                                // Delete Button
                                InkWell(
                                  onTap: () {

                                    billingNotifier.removeItem(
                                      item.medicine.id,
                                    );

                                  },   child: Icon(Icons.delete_outline, size: 18, color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Divider
                    Divider(height: 0, color: Colors.grey.shade300),

                    // Summary Section
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Subtotal:", fontSize: 12, color: Colors.grey),
                              CustomText(text: "Rs.${billingState.total.toStringAsFixed(2)}", fontSize: 12, fontWeight: FontWeight.w600),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Tax (0%):", fontSize: 12, color: Colors.grey),
                              CustomText(text: "Rs.0", fontSize: 12, fontWeight: FontWeight.w600),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(color: Colors.grey.shade300, height: 1),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "TOTAL:",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: "Rs.${billingState.total.toStringAsFixed(2)}",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Save Sale",
                      isLoading: billingState.isLoading,
                      backgroundColor: Colors.green,
                      icon: Icons.save,
                      onPressed: () async {

                        try {

                          await billingNotifier.saveSale();

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sale saved successfully"),
                              backgroundColor: Colors.green,
                            ),
                          );

                        } catch (e) {

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: Colors.red,
                            ),
                          );

                        }

                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      text: "Print Bill",
                      onPressed: billingState.cartItems.isNotEmpty ? printBill : () {},
                      backgroundColor: Colors.blue,
                      icon: Icons.print,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}