import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';

import '../../../core/network/dio_helper.dart';
import 'my_ads_controller.dart';

class MyAdsFilterController extends GetxController {
  TextEditingController priceController1 = TextEditingController();
  TextEditingController priceController2 = TextEditingController();
  TextEditingController dateController1 = TextEditingController();
  TextEditingController dateController2 = TextEditingController();
  MyAdsController myAdsController = Get.find();
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> subcategories = [];
  Map<String, dynamic>? selectedCategory;

  Map<String, dynamic>? selectedSubcategory;

  void getAllCategories() async {
    Map<String, dynamic> data = await DioHelper.getAllCategories();
    data['data']['data'].forEach((category) {
      categories.add(category);
    });
    update();
  }

  void getAllSubcategories(int categoryId) async {
    subcategories.clear();
    selectedSubcategory = null;
    update();
    Map<String, dynamic> data =
        await DioHelper.getAllSubCategories(categoryId: categoryId);
    data['data']['data'].forEach((subcategory) {
      subcategories.add(subcategory);
    });
    update();
  }

  void filterByPrice() async {
    if (selectedCategory == null ||
        selectedSubcategory == null ||
        priceController1.text.isEmpty ||
        priceController2.text.isEmpty) {
      Get.snackbar(AppWord.warning, 'الرجاء ادخال بيانات');
      return;
    }
    Get.dialog(const Center(child: CircularProgressIndicator()));
    Map<String, dynamic> data = await DioHelper.filterMyProductByPrice(
      from: priceController1.text,
      to: priceController2.text,
      subcategoryId: selectedSubcategory!['id'].toString(),
      categoryId: selectedCategory!['id'].toString(),
    );
    myAdsController.products.clear();
    if (data['data'].isEmpty) {
      Get.back();
      Get.back();
      Get.snackbar('', 'لا يوجد منتجات لهذه الشروط');
      return;
    }
    myAdsController.products.clear();
    data['data']['data'].forEach((element) {
      myAdsController.products.add(element);
    });
    myAdsController.update();
    Get.back();
    Get.back();
  }

  void filterByDate() async {
    if (selectedCategory == null ||
        selectedSubcategory == null ||
        dateController1.text.isEmpty ||
        dateController2.text.isEmpty) {
      Get.snackbar(AppWord.warning, 'الرجاء ادخال بيانات');
      return;
    }
    Get.dialog(const Center(child: CircularProgressIndicator()));
    Map<String, dynamic> data = await DioHelper.filterMyProductByDate(
      from: dateController1.text,
      to: dateController2.text,
      subcategoryId: selectedSubcategory!['id'].toString(),
      categoryId: selectedCategory!['id'].toString(),
    );
    myAdsController.products.clear();
    if (data['data'].isEmpty) {
      Get.back();
      Get.back();
      Get.snackbar('', 'لا يوجد منتجات لهذه الشروط');
      return;
    }
    myAdsController.products.clear();
    data['data']['data'].forEach((element) {
      myAdsController.products.add(element);
    });
    myAdsController.update();
    Get.back();
    Get.back();
  }

  void filter() {
    if (dateController1.text.isEmpty &&
        dateController2.text.isEmpty &&
        priceController1.text.isNotEmpty &&
        priceController2.text.isNotEmpty) {
      filterByPrice();
      return;
    }
    if (dateController1.text.isNotEmpty &&
        dateController2.text.isNotEmpty &&
        priceController1.text.isEmpty &&
        priceController2.text.isEmpty) {
      filterByDate();
      return;
    }
    Get.snackbar(AppWord.warning, 'الرجاء ادخال بيانات');
  }

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }
}
