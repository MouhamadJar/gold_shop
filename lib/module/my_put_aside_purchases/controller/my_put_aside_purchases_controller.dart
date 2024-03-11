import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MyPutAsidePurchasesController extends GetxController {
  bool isLoading = true;
  List<Map<String, dynamic>> products = [];

  void getMyPutAsidePurchases() async {
    isLoading = true;
    update();
    Get.log('requesting');

    Map<String, dynamic> data = await DioHelper.profileListsPurchasesOnHold();
    products.clear();
    if (data['data']['data'].isNotEmpty) {
      data['data']['data'].forEach((element) {products.add(element['product']);});}
    Get.log('before');
    isLoading = false;
    update();
    Get.log('after');
  }

  @override
  void onInit() {
    getMyPutAsidePurchases();
    super.onInit();
  }

}
