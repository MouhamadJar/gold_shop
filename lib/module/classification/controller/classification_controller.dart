import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/classification/model/classification_model.dart';

import '../../../core/texts/words.dart';

class ClassificationController extends GetxController {
  bool isLoading = true;
  bool isBannersEmpty = true;
  bool isSubcategoryEmpty = true;
  List<dynamic> subcategories = [];
  List<dynamic> categoriesADVS = [];
  List<String> paragraph =[];
  List<String> image =[];
  List<String> cities = [];
  String? selectedCity;
  bool isCityEmpty =true;



  void getSubcategories({required int categoryId}) async {
    Map<String, dynamic> data = await DioHelper.getAllSubCategories(categoryId: categoryId);
    data['data']['data'].forEach((element) {subcategories.add(ClassificationCategoriesModel.fromJson(json: element));});
    subcategories.isEmpty?isSubcategoryEmpty:isSubcategoryEmpty=false;
    isLoading= false;
    update();
  }
  void categoryADVS({required int categoryId}) async {
    Map<String, dynamic> data = await DioHelper.categoryADVS(categoryId: categoryId);
    data['data'].forEach((element) {categoriesADVS.add(CategoryADVSModel.fromJson(json: element));});
    categoriesADVS.isEmpty?isBannersEmpty:isBannersEmpty =false;
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
