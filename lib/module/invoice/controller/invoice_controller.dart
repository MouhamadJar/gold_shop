import 'package:get/get.dart';

import '../../../core/images/images.dart';

class InvoiceController extends GetxController{
  bool isChecked = false;
  String buttonBackground = AppImages.buttonDarkBackground;
  void checked (){
    if(isChecked){
      buttonBackground =AppImages.buttonDarkBackground;
      isChecked = !isChecked;
    }else{
      buttonBackground =AppImages.buttonLiteBackground;
      isChecked = !isChecked ;
    }
    update();
  }
}