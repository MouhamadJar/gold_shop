import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';

class AddProductController extends GetxController {
  Color fontColor = CustomColors.black;
  Color fontColor2 = CustomColors.white;
  Color cardColor = CustomColors.white;
  Color cardColor2 = CustomColors.gold;

  bool isChecked = false;

  bool isPinned = false;

  void changeColor() {
      fontColor = CustomColors.white;
      fontColor2 = CustomColors.black;
      cardColor = CustomColors.gold;
      cardColor2 = CustomColors.white;
    update();
  }
  void changeColor2() {
      fontColor = CustomColors.black;
      fontColor2 = CustomColors.white;
      cardColor = CustomColors.white;
      cardColor2 = CustomColors.gold;
    update();
  }

  void checked (){
    isChecked==false?isChecked=true:isChecked=false;
    update();
  }

  void pinned(){
    isPinned==false?isPinned= true:isPinned =false;
    update();
  }
}
