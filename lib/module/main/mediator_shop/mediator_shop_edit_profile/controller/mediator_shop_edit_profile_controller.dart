import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

import '../../../../../core/texts/words.dart';
import '../../../../../core/utils/image_handler.dart';

class MediatorShopEditProfileController extends GetxController{
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController profitController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

File? image;

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

void editProfile()async{
  await DioHelper.updateStoreProfile(
      name: nameController.text, email: emailController.text, photo: image!.path, latitude: 19.2, longitude: 10.1, country: 'country', state: 'state', city: 'city', neighborhood: 'neighborhood', street: 'street', numbers: [phoneNumberController.text], description: descriptionController.text, cost: int.parse(profitController.text));
}
}