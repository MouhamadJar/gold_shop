import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/my_purchases/model/my_purchases_model.dart';

class MyPurchasesController extends GetxController {
  bool isLoading = true;bool dateIsChecked = false;
  bool priceIsChecked = false;
  List<Map<String,dynamic>> products=[];

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
  void getMyPurchases() async {
    isLoading = true;
    update();
    Map<String,dynamic> data = await DioHelper.profileListsPurchases();
    data['data']['data'].forEach((element){products.add(element['product']);});
    isLoading = false;
  update();
  }
}
