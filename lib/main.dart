import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/auth/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Loginscreen());
  }
}
