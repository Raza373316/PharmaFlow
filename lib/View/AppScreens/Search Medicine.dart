import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/MedicineSearchCard.dart';

class Searchmedicine extends StatefulWidget {
  const Searchmedicine({super.key});

  @override
  State<Searchmedicine> createState() => _SearchmedicineState();
}

class _SearchmedicineState extends State<Searchmedicine> {
  TextEditingController search=TextEditingController();

  String Selected = 'All';
  final List<Map<String, dynamic>> Filters = [
    {'label': 'All', 'color': Colors.blue},
    {'label': 'Low Stocks', 'color': Colors.orange},
    {'label': 'Expiry', 'color': Colors.red},

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: CustomText(text: "Search Medicine",),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.lightBlue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10,),
            CustomTextField(controller: search, hintText:"Search",
            prefixIcon: Icons.search,),
            SizedBox(height: 10,),
            CustomText(text: "Filters",color: Colors.white,),

            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: Filters.map((filter){
                  return Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: FilterChip(
                      label:Text(filter['label'],
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:Colors.black

                        ),
                      ),


                      selected: Selected==filter['label'],
                      selectedColor: filter['color'],
                      backgroundColor: Colors.grey[200],
                      shape: StadiumBorder(
                        side: BorderSide(
                          color:Selected==filter['label']
                              ?filter['color']:Colors.grey[400],
                          width: 1,
                        ),
                      ),

                      showCheckmark: false,
                      onSelected: (bool selected){
                        setState(() {
                          Selected=filter['label'];
                        });

                      },),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Medicinesearchcard(price: 100, Name: 'Panadol', ExpiryDate: '10/12/21', Stock: 7,
                    Status: 'Low Stock',),
                  Medicinesearchcard(price: 100, Name: 'Agmintan', ExpiryDate: '10/12/21', Stock: 7,
                    Status: 'Expiry',),
                  Medicinesearchcard(price: 100, Name: 'Panadol', ExpiryDate: '10/12/21', Stock: 7,
                    Status: 'Low Stock',),
                  Medicinesearchcard(price: 100, Name: 'Panadol', ExpiryDate: '10/12/21', Stock: 7,
                    Status: 'Avaible',),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
