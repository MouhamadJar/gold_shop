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
  List<SubCategoryADVSModel> subcategoriesADVS = [];
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
    Map<String, dynamic> data = await DioHelper.allProducts(subcategoryId: subcategoryId);
    product.clear();
    data['data']['data'].forEach((element) { product.add(ProductsModel.fromJson(json: element));});
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
    isLoading = true;
    update();
    await DioHelper.productsByCity(city: city, subcategoryId: subcategoryId).then((value) {
      product.clear();
      update();
      if(value['data']['data'] == []){
        isSubcategoryEmpty = false;
        isLoading = false;
        update();
      }else{
        value['data']['data'].forEach((element) {
          productByCity.add(ProductsModel.fromJson(json: element));
        });
        product = productByCity;
        isLoading = false;
        update();
      }
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

  String getProductState(String state){
    switch (state){
      case '0' :
        return AppWord.available;
      case '1' :
        return AppWord.putAside;
      case '2' :
        return AppWord.reserved;
      case '3' :
        return AppWord.sold;
      default :
        return AppWord.sold;
    }
  }

}
