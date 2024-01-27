import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MyReservedPurchasesController extends GetxController{
  bool isLoading = true;
  List<Map<String,dynamic>> products= [];

  void getMyReservedPurchases ()async{
    Map<String,dynamic> data = await DioHelper.profileListsReservedPurchases();
    data['data']['data'].forEach((element){products.add(element['product']);});
    isLoading = false;
    update();
  }
}