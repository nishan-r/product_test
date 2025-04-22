import 'package:flutter/material.dart';
import 'package:product_test/modules/authentication/view/widgets/common_textfield.dart';
import 'package:product_test/utils/common_widgets/common_button.dart';
import 'package:product_test/utils/constants/app_constants.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController userNameCtr = TextEditingController();

  final TextEditingController passWordCtr = TextEditingController();


  _initializeTextField(){
    userNameCtr.text =AppConstants.userName;
    passWordCtr.text = AppConstants.password;
  }

  @override
  void initState() {
    _initializeTextField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Column(
          children: [
          CircleAvatar(radius: 60,),
          CommonTextField(controller: userNameCtr,label: 'User Name',),
          CommonTextField(controller: passWordCtr,label: 'Password',),

          Spacer(),
        
          CommonButton(title: 'Submit', onTap: (){}),
        
        
        ],),
      ),
    );
  }
}