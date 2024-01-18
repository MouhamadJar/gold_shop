import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';
import '../../../core/network/dio_helper.dart';
import '../model/category_products_model.dart';

class SubcategoryProductsController extends GetxController {
  dynamic color;
  dynamic status;
  bool sold = true;
  bool reserved = true;
  bool putAside = true;
  List<dynamic> subcategoriesADVS = [];
  List<ProductsModel> product = [];
  List<ProductsModel> productByCity = [];
  List<dynamic> image = [];
  List<String> cities = [];
  bool isBannersEmpty = true;
  bool isSubcategoryEmpty = true;
  bool isLoading = true;
  bool isCityEmpty = true;
  String? selectedCity;

  void getAllProducts({required int subcategoryId}) async {
    Map<String, dynamic> data =
        await DioHelper.allProducts(subcategoryId: subcategoryId);
    product.clear();
    data['data']['data'].forEach((element) {
      product.add(ProductsModel.fromJson(json: element));
      Get.log("""
      element : $element
      list index : ${product.length}
      """);
    });
    isLoading = false;
    product.isEmpty ? isSubcategoryEmpty == true : isSubcategoryEmpty = false;
    update();
  }

  void subcategoryADVS({required int subcategoryId}) async {
    Map<String, dynamic> data =
        await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {
      subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));
    });
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

  void chooseCity({required String city,required int subcategoryId}) async {
    Map<String, dynamic> data = await DioHelper.productsByCity(city: city, subcategoryId: subcategoryId);
    data['data']['data'].forEach((element) {
      productByCity.add(ProductsModel.fromJson(json: element));
      print(data.toString());
      product = productByCity;
    });
    update();
  }

  void getCity() async {
    Map<String, dynamic> data = await DioHelper.getCity();
    data['data'].forEach((element) {
      cities.add(element);
      selectedCity = AppWord.chooseCity;
    });
    isCityEmpty = false;
    update();
  }
}
