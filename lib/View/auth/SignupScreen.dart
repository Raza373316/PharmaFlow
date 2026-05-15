import 'package:flutter/material.dart';

import '../Custom Widget/CustomButton.dart';
import '../Custom Widget/CustomText.dart';
import '../Custom Widget/CustomTextField.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController conpassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 70),
              CustomText(
                text: "Sign Up",
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 15),
              CustomText(
                text: 'Welcome back sign in to Continue',
                fontSize: 12,
                fontWeight: FontWeight.w100,
              ),
              SizedBox(height: 15,),
              CustomTextField(controller: name, hintText: "Name"),
              SizedBox(height: 10),
              CustomTextField(controller: email, hintText: "Email"),
              SizedBox(height: 10),
              CustomTextField(controller: phone, hintText: "Phone"),
              SizedBox(height: 10),
              CustomTextField(
                controller: password,
                hintText: 'Password',
                prefixIcon: Icons.password,
                isPassword: true,
              ),
              SizedBox(height: 10,),
              CustomTextField(
                controller: conpassword,
                hintText: 'Confirm Password',
                prefixIcon: Icons.password,
                isPassword: true,
              ),
              SizedBox(height: 25),
              CustomButton(
                text: "Sign In",
                onPressed: () {},
                icon: Icons.assignment_turned_in_outlined,
              ),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              CustomButton(text: "Google Sign in", onPressed: (){},backgroundColor:Colors.black45,icon: Icons.assignment_turned_in_outlined)
            ,SizedBox(height: 30),
        
            ],
          ),
        ),
      ),
    );
  }
}
