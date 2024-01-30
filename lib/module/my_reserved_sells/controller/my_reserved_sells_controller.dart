import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MyReservedSellsController extends GetxController{
  bool isLoading= false;
  List<Map<String,dynamic>> products = [];

  void getMyReservedSells()async{
    isLoading = true;
    update();
    Map<String,dynamic> data = await DioHelper.profileListsSalesReservations();
    data['data']['data'].forEach((element){products.add(element);});
    isLoading = false;
    update();
  }
}