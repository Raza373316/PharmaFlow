import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacymanagement/View/AppScreens/MainScreenNavigation.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomButton.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';
import 'package:pharmacymanagement/View/auth/LoginScreen.dart';

import '../../Provider/UserProvider.dart';
import '../../Provider/authProvider.dart';
import '../Custom Widget/CustomTextField.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  TextEditingController search = TextEditingController();

  void initState() {
    super.initState();

    Future.microtask(() {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      ref.read(userProvider.notifier).fetchUser(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    return Scaffold(

      appBar: AppBar(
        title: CustomText(text: "PharmaFlow",color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            UserAccountsDrawerHeader(
              accountName: Text(
                userState.user?.name ?? "Loading...",
              ),

              accountEmail: Text(
                userState.user?.email ?? "",
              ),

              currentAccountPicture: const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Dashboard"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.medication),
              title: const Text("Medicines"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Sales"),
              onTap: () {},
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {

                await ref.read(authProvider.notifier).logout();

                if (!context.mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Loginscreen(),
                  ),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue.shade300,

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            CustomTextField(
              controller: search,
              hintText: "Search",
              prefixIcon: Icons.search,
              onTap: () {},
              backgroundcolor: Colors.blue.shade100,
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    icon: Icons.money,
                    label: "Total sales today",
                    value: "25500 pkr",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _infoCard(
                    icon: Icons.countertops_rounded,
                    label: "Low Stock Items",
                    value: "21",
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    icon: Icons.event_busy,
                    label: "Expiry Soon",
                    value: "5",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _infoCard(
                    icon: Icons.dashboard,
                    label: "Total Items",
                    value: "321",
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomText(
              text: "Quick Action",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Add Medicne",
                    icon: Icons.medication,height: 40,
                    fontsize: 12,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainNavigationScreen(initialIndex: 2,)));
                    },
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: CustomButton(
                    text: "Create Bill",
                    height: 40,
                    icon: Icons.receipt_long,
                    fontsize: 12,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainNavigationScreen(initialIndex: 3,)));

                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoCard({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white60,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 6),
            Expanded(child: CustomText(text: label, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 10),
        CustomText(text: value,fontSize: 22,fontWeight: FontWeight.bold,),
      ],
    ),
  );
}
