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
    {"name": "Agmintin", "stock": 20, "price": 450},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      backgroundColor: Colors.lightBlue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 5),

            // Search Bar
            TextField(
              controller: search,
              decoration: InputDecoration(
                hintText: 'Search medicine',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),

            SizedBox(height: 10),

            // Available Medicines Label
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Available Medicines",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
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
                              Text(
                                medicine["name"],
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Rs.${medicine["price"]} | Stock: ${medicine["stock"]}",
                                style: TextStyle(fontSize: 11, color: Colors.grey),
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
              child: Text(
                "Your Bill",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),

            SizedBox(height: 5),

            // Cart Items List
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                child: Text(
                  "No items in cart",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              )
                  : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartItems[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Medicine name and total price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Rs.${item.price} each",
                                  style: TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Rs.${item.total}",
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Qty: ${item.quantity}",
                                  style: TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        // Quantity controls
                        Row(
                          children: [
                            // Minus button
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: IconButton(
                                onPressed: () =>
                                    updateQuantity(index, item.quantity - 1),
                                icon: Icon(Icons.remove, size: 16, color: Colors.red),
                                padding: EdgeInsets.all(4),
                                constraints: BoxConstraints(),
                              ),
                            ),

                            SizedBox(width: 8),

                            // Quantity text
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${item.quantity}",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),

                            SizedBox(width: 8),

                            // Plus button
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: IconButton(
                                onPressed: () =>
                                    updateQuantity(index, item.quantity + 1),
                                icon: Icon(Icons.add, size: 16, color: Colors.green),
                                padding: EdgeInsets.all(4),
                                constraints: BoxConstraints(),
                              ),
                            ),

                            Spacer(),

                            // Remove button
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: IconButton(
                                onPressed: () => removeFromCart(index),
                                icon: Icon(Icons.delete, size: 16, color: Colors.red),
                                padding: EdgeInsets.all(4),
                                constraints: BoxConstraints(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            // Summary Section
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Subtotal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal:", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text("Rs.$subtotal", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),

                  SizedBox(height: 6),

                  // Tax
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tax (5%):", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text("Rs.$tax", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Divider
                  Divider(color: Colors.grey.shade300),

                  // Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rs.$total",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: cartItems.isNotEmpty ? () {
                      // Save sale logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Bill saved! Total: Rs.$total"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } : null,
                    icon: Icon(Icons.check),
                    label: Text("Save Sale"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      disabledBackgroundColor: Colors.grey,
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: cartItems.isNotEmpty ? () {
                      // Print bill logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Bill printed!"),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    } : null,
                    icon: Icon(Icons.print),
                    label: Text("Print Bill"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      disabledBackgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
          ],
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
