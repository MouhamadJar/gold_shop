import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MyPutAsideSellsController extends GetxController{
  bool isLoading = true;
  List<Map<String,dynamic>> products = [];

  void getMyPutAsideProducts()async{
    Map<String,dynamic> data = await DioHelper.profileListsSalesOnHold();
    data['data']['data'].forEach((element){products.add(element);});
    isLoading = false;
    update();
  }
}