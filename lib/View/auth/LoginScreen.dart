import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/AppScreens/MainScreenNavigation.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomButton.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';

import '../Custom Widget/CustomText.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 70),
            CustomText(
              text: "Login",
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 15),
            CustomText(
              text: 'Welcome back sign in to Continue',
              fontSize: 12,
              fontWeight: FontWeight.w100,
            ),
            SizedBox(height: 20),
            CustomTextField(controller: email, hintText: "Email"),
            SizedBox(height: 15),
            CustomTextField(
              controller: password,
              hintText: 'Password',
              prefixIcon: Icons.password,
              isPassword: true,
            ),
            SizedBox(height: 5,),

            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {},
                child: CustomText(
                  text: "ForgetPassword",
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 25),
            CustomButton(
              text: "Sign In",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainNavigationScreen()));
              },
              icon: Icons.assignment_turned_in_outlined,
            ),
            SizedBox(height: 10,),
            Divider(),
            SizedBox(height: 10,),
            CustomButton(text: "Google Sign in", onPressed: (){},backgroundColor:Colors.black45,icon: Icons.assignment_turned_in_outlined)

          ],

        )
      ),
    );
  }
}
