import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';
import 'package:gold_shop/core/texts/words.dart';

import '../../../../core/colors/colors.dart';
import '../view/main_screen_view.dart';


class MainScreenController extends GetxController{
  int currentIndex = 1 ;
  bool icon = false;
  Color selectedColor = CustomColors.yellow;
  Color unSelectedColor = CustomColors.white;
  bool loader = true;
 void logout()async{
   await DioHelper.logout().then((value) {
     StorageHandler().removeToken();
     StorageHandler().removeUserId();
     StorageHandler().removeSignature();
     StorageHandler().removeRole();
     StorageHandler().removePhoto();
     StorageHandler().removeUserName();
     StorageHandler().removeVerification();
     loader = false;
     Get.offAll(const MainScreen(),
         transition: Transition.rightToLeft,
         duration:
         const Duration(milliseconds: 700));
     ControllerSnackBar(errorTitle: AppWord.done,errorMessage: AppWord.loggedOut);
     update();
   });
 }
}