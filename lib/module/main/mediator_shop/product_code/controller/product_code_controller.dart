import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/module/authentication/view/login_screen.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';

class ProductCodeController extends GetxController {
  TextEditingController codeController = TextEditingController();
  bool loader = true;

  void logout () async {
    loader = true;
    update();
    await DioHelper.storeLogout().then((value) {
      StorageHandler().removeMediatorToken();
      StorageHandler().removeMediatorId();
      StorageHandler().removeRole();
      StorageHandler().removeSignature();
      StorageHandler().removeMediatorName();
      StorageHandler().removeMediatorPhoto();
      StorageHandler().removeMediatorVerification();
      Get.offAll(const MainScreen(),transition: Transition.fade,duration:  const Duration(milliseconds: 700));
      loader = false;
      update();
    });
    update();
  }
}
