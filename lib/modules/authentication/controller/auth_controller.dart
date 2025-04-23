import 'package:get/get.dart';

class AuthController extends GetxController{

  var hidePassword = false.obs;

  obscurePAssword(){
    hidePassword.value = !hidePassword.value;
  }

}