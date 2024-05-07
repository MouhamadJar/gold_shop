import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/image_handler.dart';
import '../../main/user/view/main_screen_view.dart';
import '../../profile/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  ProfileController profileController = Get.find();

  ///declare variables and controller for each field
  bool zoomed =false;
  File? image;


  late TextEditingController firstNameController;

  late TextEditingController lastNameController;

  late TextEditingController emailController;

  late TextEditingController phoneNumberController;

  late TextEditingController descriptionController;

  void pickImage() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        image = File(value);
        update();
        Get.snackbar(AppWord.done, '');
        return;
      }
      Get.snackbar(AppWord.warning, AppWord.doNotPickImage);
      return;
    });
  }


  void editProfile() async {
    DioHelper.updateProfile(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text == profileController.user!.email ? null :emailController.text,
            photo: image,
    )
        .then((value) {
      if (value['errors'] != null) {
        Get.snackbar(AppWord.warning, value['message']);
        return;
      } else {
        Get.offAll(const MainScreen());
        Get.snackbar(AppWord.done, AppWord.editProfile);
        return;
      }
    });
  }


  @override
  void onInit() {
    ///init variables and controller for each field
    firstNameController = TextEditingController(text: profileController.user!.firstName);
    lastNameController = TextEditingController(text: profileController.user!.lastName);
    emailController = TextEditingController(text: profileController.user!.email);
    phoneNumberController = TextEditingController(text: profileController.user!.phoneNumber);
    descriptionController = TextEditingController(text: profileController.user!.description);
    super.onInit();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
