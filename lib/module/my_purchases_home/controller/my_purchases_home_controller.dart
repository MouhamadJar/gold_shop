import 'package:get/get.dart';

class MYPurchasesHomeController extends GetxController {
  int index = 0;
  bool dateIsChecked = false;
  bool priceIsChecked = false;
  void dateCheck(){
    if(dateIsChecked){
      dateIsChecked = true;
    }else{
      dateIsChecked = false;
    }
    update();
  }
  void priceCheck(){
    if(priceIsChecked){
      priceIsChecked = true;
    }else{
      priceIsChecked = false;
    }
    update();
  }
}
