import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MyPutAsideSellsController extends GetxController{
  bool isLoading = true;
  List<Map<String,dynamic>> products = [];

  void getMyPutAsideProducts()async{
    isLoading = true;
    update();
    Get.log('req');
    Map<String,dynamic> data = await DioHelper.profileListsSalesOnHold();
    data['data']['data'].forEach((element){products.add(element);});
    Get.log('before');
    isLoading = false;
    update();
    Get.log('after');
  }
}