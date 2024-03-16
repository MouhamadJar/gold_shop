import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/module/authentication/view/login_screen.dart';

class ProductCodeController extends GetxController {
  TextEditingController codeController = TextEditingController();
  bool loader = true;

  void logout () async {
    loader = true;
    update();
    await DioHelper.storeLogout().then((value) {
      StorageHandler().removeToken();
      StorageHandler().removeUserId();
      StorageHandler().removeRole();
      StorageHandler().removeSignature();
      Get.offAll(const LoginScreen(),transition: Transition.fade,duration:  const Duration(milliseconds: 700));
      loader = false;
      update();
    });
    update();
  }
}
