import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MyPutAsidePurchasesController extends GetxController{
  bool isLoading = true;
  List<Map<String,dynamic>> products = [];

  void getMyPutAsidePurchases ()async{
   Map<String,dynamic> data = await DioHelper.profileListsPurchasesOnHold();
   data['data']['data'].forEach((element){products.add(element['product']);});
   isLoading = false ;
   update();
  }
}