import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/category_products/controller/category_products_controller.dart';

import '../../category_products/model/category_products_model.dart';

class SortController extends GetxController{
  List<ProductsModel> products = [];
  SubcategoryProductsController subcategoryProductsController = Get.find();

  bool caratHTL = false;
  bool caratLTH = true;
  bool priceHTL = false;
  bool priceLTH = true;
  bool weightHTL = false;
  bool weightLTH = true;

  bool? carat;
  bool? price;
  bool? weight;
//
// void caratCheckHTL(){
//   caratHTL == true?caratHTL = false: caratHTL = true;
//   caratLTH =false;
//   update();
// }
// void priceCheckHTL(){
//   priceHTL == true?priceHTL = false: priceHTL =true;
//   priceLTH = false;
//   update();
// }
// void weightCheckHTL(){
//   weightHTL == true?weightHTL = false: weightHTL =true;
//   weightLTH = false;
//   update();
// }
// void caratCheckLTH(){
//   caratHTL == true?caratLTH = false:caratLTH =true;
//   caratHTL =false;
//   update();
// }
// void priceCheckLTH(){
//   priceHTL == true?priceLTH = false:priceLTH =true;
//    priceHTL = false;
//   update();
// }
// void weightCheckLTH(){
//   weightHTL == true?weightLTH = false:weightLTH =true;
//   weightHTL = false;
//   update();
// }

  void sort ()async {
    Map<String,dynamic> data = await DioHelper.sort(carat: carat!, price: price!, weight: weight!);
    price = priceLTH;
    weight = weightLTH;
    carat = caratLTH;
    data['data']['data'].forEach((element){products.add(ProductsModel.fromJson(json: element));});
    Get.log(data.toString());
    subcategoryProductsController.product = products;
    subcategoryProductsController.update();
    Get.back();
    update();
  }
}