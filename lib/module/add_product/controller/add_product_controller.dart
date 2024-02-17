import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/categories/model/categories_model.dart';
import 'package:gold_shop/module/classification/model/classification_model.dart';

import '../../../core/texts/words.dart';
import '../../../core/utils/image_handler.dart';

class AddProductController extends GetxController {
  Color fontColor = CustomColors.black;
  Color fontColor2 = CustomColors.white;
  Color cardColor = CustomColors.white;
  Color cardColor2 = CustomColors.gold;
  bool isChecked = false;
  bool isPinned = false;
  bool isLoading = true;
  String categoriesTitle = AppWord.productCategory;
  String subcategoriesTitle = AppWord.productClassification;

  List<CategoriesModel> categoriesModel= [];
  List<ClassificationCategoriesModel> subcategoriesModel= [];

  File? images;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController additionController = TextEditingController();
  TextEditingController profitController = TextEditingController();
  TextEditingController currentGoldPriceController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();

  void changeColor() {
    fontColor = CustomColors.white;
    fontColor2 = CustomColors.black;
    cardColor = CustomColors.gold;
    cardColor2 = CustomColors.white;
    update();
  }

  void changeColor2() {
    fontColor = CustomColors.black;
    fontColor2 = CustomColors.white;
    cardColor = CustomColors.white;
    cardColor2 = CustomColors.gold;
    update();
  }

  void checked() {
    isChecked == false ? isChecked = true : isChecked = false;
    update();
  }

  void pinned() {
    isPinned == false ? isPinned = true : isPinned = false;
    update();
  }

  void getCategories()async{
    Map<String,dynamic> categories = await DioHelper.getAllCategories();
    categoriesModel.clear();
    categories['data']['data'].forEach((element){
    categoriesModel.add(CategoriesModel.frmJson(json: element));});
    isLoading= false;
    update();
  }
  void getSubcategories({required int categoryId})async{
    Map<String,dynamic> subcategories = await DioHelper.getAllSubCategories(categoryId: categoryId);
    subcategoriesModel.clear();
    subcategories['data']['data'].forEach((element){
      subcategoriesModel.add(ClassificationCategoriesModel.fromJson(json: element));});
  }

  void pickImage() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        images = File(value);
        update();
        Get.snackbar(AppWord.done, '');
        return;
      }
      Get.snackbar(AppWord.warning, AppWord.doNotPickImage);
      return;
    });
  }

  void addProduct() async {
    await DioHelper.store(
      image: images!.path,
      description: descriptionController.text,
      age: ageController.text,
      weight: weightController.text,
      carat: 18,
      subcategoryId: 1,
      currentGoldPrice: currentGoldPriceController.text,
      profit: profitController.text,
      addition: additionController.text,
      details: 'details',
      manufacturer: manufacturerController.text,
      manufacturerType: 'manufacturerType',
      toggle: isPinned,
      deliveryType: 1,
      phoneNumber: '',
      stores: ['stores'],
      discountToggle: isChecked==false?0:1,
    );
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
}
