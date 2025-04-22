import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  RxnString selectedImagePath = RxnString();

  selectImage(XFile selectImageFile) {
    selectedImagePath.value = selectImageFile.path;
  }
}
