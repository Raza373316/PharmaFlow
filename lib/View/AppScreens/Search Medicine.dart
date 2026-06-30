import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/MedicineSearchCard.dart';

import '../../Provider/MedicineProvider.dart';

class Searchmedicine extends ConsumerStatefulWidget {

  final String initialFilter;

  const Searchmedicine({
    super.key,
    this.initialFilter = "All",
  });

  @override
  ConsumerState<Searchmedicine> createState() =>
      _SearchmedicineState();
}
class _SearchmedicineState extends ConsumerState<Searchmedicine> {
  TextEditingController search=TextEditingController();
  String getStatus(dynamic medicine) {
    final now = DateTime.now();

    try {
      final expiry = DateTime.parse(medicine.expiryDate);

      if (expiry.isBefore(now.add(const Duration(days: 30)))) {
        return "Expiry Soon";
      }
    } catch (_) {}

    if (medicine.stock <= 10) {
      return "Low Stock";
    }

    return "Available";
  }

  late String Selected;
  String searchText = "";
  @override
  void initState() {
    super.initState();

    Selected = widget.initialFilter;
  }
  final List<Map<String, dynamic>> Filters = [
    {'label': 'All', 'color': Colors.blue},
    {'label': 'Low Stocks', 'color': Colors.orange},
    {'label': 'Expiry', 'color': Colors.red},

  ];
  @override
  Widget build(BuildContext context) {
    final medicines = ref.watch(medicineStreamProvider);
    return Scaffold(

      appBar: AppBar(
        title: CustomText(text: "Search Medicine",
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.lightBlue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10,),
            CustomTextField(
              controller: search,
              hintText: "Search",
              prefixIcon: Icons.search,
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
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
                      label:CustomText(text: filter['label'],

                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:Colors.black


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
              child: medicines.when(
                data: (medicineList) {
                  if (medicineList.isEmpty) {
                    return const Center(
                      child: Text("No medicines found"),
                    );
                  }

                  final query = search.text.toLowerCase();

                  List filteredMedicines = medicineList.where((medicine) {
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

// Low Stock Filter
                  if (Selected == "Low Stocks") {
                    filteredMedicines = filteredMedicines.where((medicine) {
                      return medicine.stock <= 10;
                    }).toList();
                  }

// Expiry Filter
                  if (Selected == "Expiry") {
                    final now = DateTime.now();

                    filteredMedicines = filteredMedicines.where((medicine) {
                      try {
                        final expiry = DateTime.parse(medicine.expiryDate);


                        return expiry.isBefore(
                          now.add(const Duration(days: 30)),
                        );
                      } catch (e) {
                        return false;
                      }
                    }).toList();
                  }

                  return ListView.builder(
                    itemCount: filteredMedicines.length,
                    itemBuilder: (context, index) {
                      final medicine = filteredMedicines[index];


                      return Medicinesearchcard(
                        Name: medicine.name,
                        price: medicine.sellPrice,
                        ExpiryDate: medicine.expiryDate,
                        Stock: medicine.stock,
                        Status: getStatus(medicine),
                      );
                    },
                  );
                },
                loading: () =>
                const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
              ),
            )
          ],
        ),
      ),
    );
  }
}
