import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_test/modules/authentication/view/widgets/common_textfield.dart';
import 'package:product_test/modules/profile/controller/profile_controller.dart';
import 'package:product_test/utils/common_widgets/common_button.dart';
import 'package:product_test/utils/constants/app_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  final TextEditingController userNameCtr = TextEditingController();
  final TextEditingController passWordCtr = TextEditingController();

  _initializeTextField() {
    userNameCtr.text = AppConstants.userName;
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Obx(
                  () => CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.amber,
                      backgroundImage: _profileController
                                  .selectedImagePath.value ==
                              null
                          ? AssetImage('assets/images/dummyProfile.png')
                          : FileImage(File(
                              _profileController.selectedImagePath.value!))),
                ),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Choose Image from :',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      pickImage(ImageSource.camera).then(
                                        (value) {
                                          if (context.mounted) Navigator.pop(context);
                                        },
                                      );
                                    },
                                    leading: Icon(
                                      Icons.camera,
                                      color: Colors.red,
                                    ),
                                    title: Text('Camera'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      pickImage(ImageSource.gallery).then(
                                        (value) {
                                          if (context.mounted) Navigator.pop(context);
                                        },
                                      );
                                    },
                                    leading: Icon(
                                      Icons.image,
                                      color: Colors.blue,
                                    ),
                                    title: Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                )
              ],
            ),
            SizedBox(height: 30),
            CommonTextField(
              controller: userNameCtr,
              label: 'User Name',
            ),
            SizedBox(height: 20),
            CommonTextField(
              controller: passWordCtr,
              label: 'Password',
            ),
            Spacer(),
            CommonButton(title: 'Submit', onTap: () {
              _saveChanges();
            }),
          ],
        ),
      ),
    );
  }

  Future<XFile?> pickImage(ImageSource type) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: type);
    if (pickedFile != null) {
      _profileController.selectImage(pickedFile);
    }
    return pickedFile;
  }

  _saveChanges(){
    if (userNameCtr.text == AppConstants.userName && passWordCtr.text == AppConstants.password) {
      Get.snackbar('Warning', 'No Change Detected');
    } else {
      Get.snackbar('Success', 'Profile updated successfully');
    }
  }
}
