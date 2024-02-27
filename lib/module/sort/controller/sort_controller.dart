import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/category_products/controller/category_products_controller.dart';

import '../../category_products/model/category_products_model.dart';

class SortController extends GetxController{
  List<ProductsModel> products = [];
  SubcategoryProductsController subcategoryProductsController = Get.find();

  bool caratHTL = false;
  bool caratLTH = false;
  bool priceHTL = false;
  bool priceLTH = false;
  bool weightHTL = false;
  bool weightLTH = false;

  int? carat ;
  int? price ;
  int? weight;


  void htlValuesCheck(){
    caratHTL == true ? carat = 1: caratLTH == true? carat= 0: carat = null ;
    priceHTL == true ? price = 1 : priceLTH == true ? price = 0 : price=null;
    weightHTL == true ? weight = 1: weightLTH == true ? weight = 0 : weight=null;
  }

  void sort ()async {
    htlValuesCheck();
    update();
    Map<String,dynamic> data = await DioHelper.sort(carat: carat, price: price, weight: weight);
    data['data']['data'].forEach((element){products.add(ProductsModel.fromJson(json: element));});
    subcategoryProductsController.product = products;
    subcategoryProductsController.update();
    Get.back();
    update();
  }
}