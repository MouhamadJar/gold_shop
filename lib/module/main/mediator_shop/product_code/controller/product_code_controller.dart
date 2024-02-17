import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';

class ProductCodeController extends GetxController {
  TextEditingController codeController = TextEditingController();
  bool isLoading = false;

  void sendCode() async {
    isLoading = true;
    update();
    await DioHelper.sendCode(code: codeController.text).then((value) {
      Get.log(value.toString());
      isLoading = false;
      update();
      if (!value['status']) {
        Get.snackbar(AppWord.warning, AppWord.codeNotCorrect);
      }
    });
  }
}
