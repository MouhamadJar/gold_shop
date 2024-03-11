import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class MyAdsController extends GetxController {
  int index = 0;
  bool dateIsChecked = false;
  bool priceIsChecked = false;
  bool isLoading = true;
  List<Map<String, dynamic>> products = [];

  void dateCheck(bool newVal) {
    dateIsChecked = newVal;
    sortProductsByDate();
  }

  void priceCheck(bool newVal) {
    priceIsChecked = newVal;
    sortProductsByPrice();
  }

  void getMyProducts() async {
    isLoading = true;
    update();
    Map<String, dynamic> data = await DioHelper.profileListsMyProducts();
    products.clear();
    data['data']['data'].forEach((element) {
      products.add(element);
    });
    isLoading = false;
    update();
  }

  void sortProductsByPrice() async {
    isLoading = true;
    update();
    Map<String, dynamic> data =
        await DioHelper.sortMyProductByPrice(fromUpToDownPrice: priceIsChecked);
    products.clear();
    data['data']['data'].forEach((element) {
      products.add(element);
    });
    isLoading = false;
    update();
  }

  void sortProductsByDate() async {
    isLoading = true;
    update();
    Map<String, dynamic> data =
    await DioHelper.sortMyProductByDate(fromUpToDownDate: dateIsChecked);
    products.clear();
    data['data']['data'].forEach((element) {
      products.add(element);
    });
    isLoading = false;
    update();
  }
}
