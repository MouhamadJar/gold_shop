import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/my_purchases/model/my_purchases_model.dart';

class MyPurchasesController extends GetxController {
  bool isLoading = true;
  MyPurchasesModel? model;
  Map<String,dynamic> products = {};

  void getMyPurchases() async {
    Map<String, dynamic> data = await DioHelper.profileListsPurchases();
    data['data']['data'].forEach((element){products.addAll(element);});
    print(products.toString());
  update();
  }
}
