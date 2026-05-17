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
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomButton.dart';

// Model for medicine in cart
class CartItem {
  String name;
  int price;
  int quantity;

  CartItem({required this.name, required this.price, required this.quantity});

  int get total => price * quantity;
}

class Billingscreen extends StatefulWidget {
  const Billingscreen({super.key});

  @override
  State<Billingscreen> createState() => _BillingscreenState();
}

class _BillingscreenState extends State<Billingscreen> {
  TextEditingController search = TextEditingController();

  // Sample medicine list
  List<Map<String, dynamic>> medicines = [
    {"name": "Panadol", "stock": 29, "price": 100},
    {"name": "Calpol", "stock": 9, "price": 170},
    {"name": "Aspirin", "stock": 45, "price": 80},
    {"name": "Ibuprofen", "stock": 20, "price": 120},
  ];

  // Cart items list
  List<CartItem> cartItems = [];

  // Calculate subtotal
  int get subtotal => cartItems.fold(0, (sum, item) => sum + item.total);

  // Calculate tax (5%)
  int get tax => (subtotal * 0.05).toInt();

  // Calculate total
  int get total => subtotal + tax;

  // Add medicine to cart
  void addToCart(String name, int price) {
    setState(() {
      // Check if medicine already in cart
      int index = cartItems.indexWhere((item) => item.name == name);

      if (index >= 0) {
        // If exists, increase quantity
        cartItems[index].quantity++;
      } else {
        // Add new item to cart
        cartItems.add(CartItem(name: name, price: price, quantity: 1));
      }
    });
  }

  // Remove medicine from cart
  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // Update quantity
  void updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  // Print bill
  void printBill() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(text: "Bill printed! Total: Rs.$total", color: Colors.white),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Save sale
  void saveSale() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(text: "Bill saved! Total: Rs.$total", color: Colors.white),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    var medicine = medicines[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Medicine Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: medicine["name"],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: "Rs.${medicine["price"]} | Stock: ${medicine["stock"]}",
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),

                          // Plus Button
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: IconButton(
                              onPressed: () => addToCart(medicine["name"], medicine["price"]),
                              icon: Icon(Icons.add, size: 18, color: Colors.blue),
                              padding: EdgeInsets.all(4),
                              constraints: BoxConstraints(),
                            ),
                          ),
                        ],
                      ),
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
                      child: cartItems.isEmpty
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
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          var item = cartItems[index];
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
                                        text: item.name,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomText(
                                        text: "Rs.${item.price} each",
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
                                              onTap: () => updateQuantity(index, item.quantity - 1),
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
                                              onTap: () => updateQuantity(index, item.quantity + 1),
                                              child: Padding(
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
                                    text: "Rs.${item.price}",
                                    fontSize: 11,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                // Total Price
                                Expanded(
                                  flex: 1,
                                  child: CustomText(
                                    text: "Rs.${item.total}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(width: 8),

                                // Delete Button
                                InkWell(
                                  onTap: () => removeFromCart(index),
                                  child: Icon(Icons.delete_outline, size: 18, color: Colors.red),
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
                              CustomText(text: "Rs.$subtotal", fontSize: 12, fontWeight: FontWeight.w600),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Tax (5%):", fontSize: 12, color: Colors.grey),
                              CustomText(text: "Rs.$tax", fontSize: 12, fontWeight: FontWeight.w600),
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
                                text: "Rs.$total",
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
                      onPressed: cartItems.isNotEmpty ? saveSale : () {},
                      backgroundColor: Colors.green,
                      icon: Icons.check,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      text: "Print Bill",
                      onPressed: cartItems.isNotEmpty ? printBill : () {},
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