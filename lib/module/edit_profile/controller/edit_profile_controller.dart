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

  File? image;

  late TextEditingController firstNameController;

  late TextEditingController lastNameController;

  late TextEditingController userNameController;

  late TextEditingController emailController;

  late TextEditingController phoneNumberController;

  late String country;

  late String state;

  late String city;

  late String neighborhood;

  late String street;

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
            email: emailController.text,
            photo: image!.path,
            longitude: 39.612236,
              latitude: 24.470901,
            country: country,
            state: state,
            city: city,
            neighborhood: neighborhood,
            street: street).then((value) {
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
    firstNameController =
        TextEditingController(text: profileController.user!.firstName);
    lastNameController =
        TextEditingController(text: profileController.user!.lastName);
    userNameController =
        TextEditingController(text: profileController.user!.firstName);
    emailController =
        TextEditingController(text: profileController.user!.email);
    phoneNumberController =
        TextEditingController(text: profileController.user!.phoneNumber);

    country = profileController.user!.country;
    state = profileController.user!.state;
    city = profileController.user!.city;
    neighborhood = profileController.user!.neighborhood;
    street = profileController.user!.street;
    super.onInit();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
