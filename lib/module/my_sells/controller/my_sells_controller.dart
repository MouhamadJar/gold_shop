import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MySellsController extends GetxController{
  bool isLoading = true;
  List<Map<String,dynamic>> products = [];
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

  void getMySells()async{
    isLoading =true;
    update();
    Map<String,dynamic> data = await DioHelper.profileListsSales();
    data['data']['data'].forEach((element){products.add(element);});
    isLoading = false;
    update();
  }
}