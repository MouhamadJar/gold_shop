import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MyAdsController extends GetxController {
  int index = 0;
  bool dateIsChecked = false;
  bool priceIsChecked = false;
  bool isLoading = true;
  List<Map<String,dynamic>> products = [];

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

  void getMyProducts ()async{
    Map<String,dynamic> data = await DioHelper.profileListsMyProducts();
    data['data']['data'].forEach((element){products.add(element);});
    isLoading = false ;
    update();
  }
}
