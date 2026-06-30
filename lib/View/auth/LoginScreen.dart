import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacymanagement/View/AppScreens/MainScreenNavigation.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomButton.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomTextField.dart';
import 'package:pharmacymanagement/View/auth/SignupScreen.dart';

import '../../Provider/authProvider.dart';
import '../Custom Widget/CustomText.dart';

class Loginscreen extends ConsumerStatefulWidget {
  const Loginscreen({super.key});

  @override
  ConsumerState<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends ConsumerState<Loginscreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
  final authNotifier = ref.read(authProvider.notifier);

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
              isLoading: authState.isLoading,
              onPressed: () async{


                final user = await authNotifier.login(
                    email: email.text.trim()
                    ,password: password.text.trim()

                );

                if(user == null ){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("SignIn Failed")),
                  );
                  return ;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainNavigationScreen(),
                  ),
                );
              },
              icon: Icons.assignment_turned_in_outlined,
            ),
            SizedBox(height: 10,),
            Divider(),
            SizedBox(height: 10,),
            CustomButton(text: "Google Sign in", onPressed: (){},
                backgroundColor:Colors.black45,icon: Icons.assignment_turned_in_outlined),
                SizedBox(height: 10,),
                Row(  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(text: "If you don't acount?"),
                    InkWell(child: CustomText(text: "Sign Up",
                    color: Colors.blueAccent,),
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Signupscreen(),
                        ),
                      );
                        },)
                  ],
                ),
          ],

        )
      ),
    );
  }
}
