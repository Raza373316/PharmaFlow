import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    email.text="kjan";
    return Scaffold(
      body: Column(
        children: [
          Text("Login"),
       CustomTextField(controller: email, hintText: "Email")
        ],
      ),
    );

  }
}
