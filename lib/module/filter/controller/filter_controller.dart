import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/category_products/model/category_products_model.dart';
import '';
import '../../../core/texts/words.dart';
import '../../category_products/controller/category_products_controller.dart';

class FilterController extends GetxController {
  String title = AppWord.productCalibre;
  int? value = 0;
  List<ProductsModel> filteredProducts = [];
  TextEditingController fromPriceController = TextEditingController();
  TextEditingController toPriceController = TextEditingController();
  TextEditingController fromWeightController = TextEditingController();
  TextEditingController toWeightController = TextEditingController();
  SubcategoryProductsController subcategoryProductsController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checked = false;

  int carat18 =18;
  int carat21 =21;
  int carat22 =22;
  int carat24 =24;
  int? carat;

  void caratNotNull(){
    try {
      if (carat== null){
        Get.snackbar(AppWord.warning, AppWord.youHaveToChooseCaliber);
      }
    }catch(error) {
      error;
    }
  }
  void pupUpText() {
    if (value == null) {
      title = AppWord.productCalibre;
    }
    if (value == 0) {
      title = '${AppWord.caliber} \t 24';
      carat = carat24;
    } else if (value == 1) {
      title = '${AppWord.caliber} \t 22';
      carat = carat22;
    } else if (value == 2) {
      title = '${AppWord.caliber} \t 21';
      carat = carat21;
    } else {
      title = '${AppWord.caliber} \t 18';
      carat = carat18;
    }
    update();
  }


  void checkValue() {
   checked =true;
    update();
  }
  void uncheckValue() {
   checked =false;
    update();
  }

  void weightFilter() async {
    Map<String, dynamic> data = await DioHelper.weightFilter(
        carat: carat!,
        fromWeight: double.tryParse(fromWeightController.text)!,
        toWeight: double.tryParse(toWeightController.text)!);
    print(data.toString());
    if(data['data'].isEmpty){
      Get.snackbar(AppWord.warning, AppWord.noDataForThisFilter);
    }

    data['data']['data'].forEach((element) {
      filteredProducts.add(ProductsModel.fromJson(json: element));
      update();
    });
    subcategoryProductsController.product = filteredProducts;
    subcategoryProductsController.update();
    Get.back();
  }

  void priceFilter() async {
    Map<String, dynamic> data = await DioHelper.priceFilter(
        carat: carat!,
        fromPrice: double.tryParse(fromPriceController.text)!,
        toPrice: double.tryParse(toPriceController.text)!);
    if(data['data'].isEmpty||data['data']==null){
      Get.snackbar(AppWord.warning, AppWord.noDataForThisFilter);
      return;
    }
    data['data']['data'].forEach((element) {
      filteredProducts.add(ProductsModel.fromJson(json: element));
      update();
    });
    subcategoryProductsController.product = filteredProducts;
    subcategoryProductsController.update();
    Get.back();
  }
}
