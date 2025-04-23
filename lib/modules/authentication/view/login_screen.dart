import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_test/modules/authentication/view/widgets/common_textfield.dart';
import 'package:product_test/utils/constants/app_assets.dart';
import 'package:product_test/utils/constants/app_colors.dart';
import 'package:product_test/utils/constants/app_spaces.dart';
import '../../../utils/common_widgets/common_button.dart';
import '../../../utils/constants/app_constants.dart';
import '../../home/view/home_screen.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});


  final _authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cmHeight20,
                    Image.asset(AppAssets.appLogo,
                      height: size.height * .2,
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Hi, Welcome back, you've been missed",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              height: size.height * .4,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CommonTextField(
                      controller: emailController,
                      label: 'Email',
                      validator: (p0) {
                        if (p0?.isEmpty??false) {
                          return '* required';
                        }
                        return null;
                      },
                    ),
                    cmHeight20,
                    Obx(() => CommonTextField(
                      controller: passwordController,
                      validator: (p0) {
                        if (p0?.isEmpty??false) {
                          return '* required';
                        }
                        return null;
                      },
                      label: 'Password',
                      obscureText: _authController.hidePassword.value,
                      onSuffixIconTapped: () {
                        _authController.obscurePAssword();
                      },
                    ),),
                    cmHeight30,
                    CommonButton(
                        title: 'Login',
                        onTap: () {
                          if (_formKey.currentState?.validate()??false) {
                            final isValid = _checkUserNameAndPasswordValid();
                          if (isValid) {
                            Get.offAll(HomeScreen());
                          } else {
                            Get.snackbar('Error', 'Invalid Credentials');
                          }
                          }
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _checkUserNameAndPasswordValid() {
    if (emailController.text == AppConstants.userName &&
        passwordController.text == AppConstants.password) {
      return true;
    }
    return false;
  }
}
