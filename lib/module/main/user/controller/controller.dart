import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';
import 'package:gold_shop/core/texts/words.dart';

import '../../../../core/colors/colors.dart';


class MainScreenController extends GetxController{
  int currentIndex = 1 ;
  bool icon = false;
  Color selectedColor = CustomColors.yellow;
  Color unSelectedColor = CustomColors.white;
 Map <String,dynamic> loggingOut ={};
 void logout()async{
   Map<String,dynamic> data = await DioHelper.logout();
   loggingOut = data ;
   StorageHandler().removeToken();
   Get.snackbar('',AppWord.loggedOut);
   update();
 }
}