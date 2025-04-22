import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_test/modules/authentication/view/widgets/common_textfield.dart';

import '../../../utils/common_widgets/common_button.dart';
import '../../../utils/constants/app_constants.dart';
import '../../home/view/home_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Lets Get Started',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
            CommonTextField(
              controller: emailController,
              label: 'Email',
            ),
            CommonTextField(
              controller: passwordController,
              label: 'Password',
            ),
            CommonButton(
              title: 'Login',
              onTap: () {
               final isValid =  _checkUserNameAndPasswordValid();
               if(isValid){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
               }
               else{
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    content: Text('Invalid Credentials'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
               }
              })
          ],
        ),
      ),
    );
  }


  _checkUserNameAndPasswordValid(){
    if(emailController.text == AppConstants.userName && passwordController.text == AppConstants.password){
      return true;
    }
    return false;
  }
}



