import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacymanagement/Provider/UserProvider.dart';
import 'package:pharmacymanagement/View/AppScreens/Dashboard.dart';
import 'package:pharmacymanagement/View/AppScreens/MainScreenNavigation.dart';
import 'package:pharmacymanagement/View/auth/LoginScreen.dart';

import '../../Modal/userModal.dart';
import '../../Provider/authProvider.dart';
import '../Custom Widget/CustomButton.dart';
import '../Custom Widget/CustomText.dart';
import '../Custom Widget/CustomTextField.dart';

class Signupscreen extends ConsumerStatefulWidget {
  const Signupscreen({super.key});

  @override
  ConsumerState<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends ConsumerState<Signupscreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conpassword = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);


    return Scaffold(
      backgroundColor: Colors.lightBlue.shade300,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
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
                SizedBox(height: 15),
                CustomTextField(
                  controller: name,
                  hintText: "Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Invalid";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: email,
                  hintText: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Invalid";
                    }
                    if (!value.contains("@")) {
                      return "Invalid";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: phone,
                  hintText: "Phone",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Invalid";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: password,
                  hintText: 'Password',
                  prefixIcon: Icons.password,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Invalid";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: conpassword,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.password,
                  isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Confirm Password is required";
                      }

                      if (value != password.text) {
                        return "Passwords do not match";
                      }

                      return null;
                    }
                ),
                SizedBox(height: 25),
                CustomButton(
                  text: "Sign In",
                  isLoading: authState.isLoading,
                  icon: Icons.assignment_turned_in_outlined,
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      final uid = await authNotifier.signUp(
                        email: email.text.trim(),
                        password: password.text.trim(),
                      );
                      if (uid != null) {
                        final user = UserModel(
                          uid: uid,
                          name: name.text,
                          email: email.text,
                          phone: phone.text,
                        );

                        print("Saving user to Firestore...");
                        await ref.read(userProvider.notifier).saveUser(user);
                        print("Save function called");

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MainNavigationScreen(),
                          ),
                        );
                      }

                      if (uid == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("SignIn Failed")),
                        );

                        return;
                      }

                    }
                  },
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                CustomButton(
                  text: "Google Sign in",
                  onPressed: () {
                    if (formkey.currentState!.validate()) {}
                  },
                  backgroundColor: Colors.black45,
                  icon: Icons.assignment_turned_in_outlined,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(text: "If you have acount?"),
                    InkWell(
                      child: CustomText(
                        text: "Sign in",
                        color: Colors.blueAccent,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loginscreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
