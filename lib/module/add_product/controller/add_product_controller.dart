import 'dart:io';
import 'package:dio/dio.dart' as DIO;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/categories/model/categories_model.dart';
import 'package:gold_shop/module/classification/model/classification_model.dart';
import 'package:image_picker/image_picker.dart';

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
  String calibers = AppWord.caliber;
  dynamic caliberPrice = 0;
  int appCommission = 0;

  List<CategoriesModel> categoriesModel = [];
  List<ClassificationCategoriesModel> subcategoriesModel = [];

  TextEditingController descriptionController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController(text: '0');
  TextEditingController additionController = TextEditingController(text: '0');
  TextEditingController additionDescriptionController = TextEditingController();
  TextEditingController appCommissionController = TextEditingController();
  TextEditingController totalGramPriceController = TextEditingController();
  TextEditingController totalProductPriceController = TextEditingController();
  TextEditingController profitController = TextEditingController(text: '0');
  TextEditingController currentGoldPriceController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController caliberPriceValueController = TextEditingController();
  TextEditingController offerDescriptionController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();
  int? discountToggle;
  int? toggle;
  String manufacturerType = 'local';

  List<File>? listImagePath;
  List<XFile>? images = [];
  ImagePicker photo = ImagePicker();


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

  void getCategories() async {
    isLoading = true;
    update();
    Map<String, dynamic> categories = await DioHelper.getAllCategories();
    getAppCommission();
    categoriesModel.clear();
    categories['data']['data'].forEach((element) {
      categoriesModel.add(CategoriesModel.frmJson(json: element));
    });
    isLoading = false;
    update();
  }

  void getSubcategories({required int categoryId}) async {
    Map<String, dynamic> subcategories =
        await DioHelper.getAllSubCategories(categoryId: categoryId);
    subcategoriesModel.clear();
    subcategories['data']['data'].forEach((element) {
      subcategoriesModel.add(ClassificationCategoriesModel.fromJson(json: element));
    });
  }

  void selectMultipleImage() async {
    images!.clear();
    await photo.pickMultiImage().then((value) {
      if (value.isEmpty) {
        Get.snackbar('fail', 'no image selected',
            snackPosition: SnackPosition.TOP);
        update();
      } else {
        images = value;
        for (XFile file in images!) {
          listImagePath!.add(File(file.path));
        }
        update();
      }
    });

  }

  void addProduct() async {
    List<DIO.MultipartFile> tmp = [];
    listImagePath!.forEach((element) async {
      tmp.add(await DIO.MultipartFile.fromFile(element.path));
    });
    await DioHelper.store(
      images: tmp,
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
      discountToggle: isChecked == false ? 0 : 1,
    );
  }

  void getAllCaratPrices()async{
    Map<String,dynamic> data = await DioHelper.getAllCaratPrices();
    update();
    caliberPrice = data['data']['data'][calibers];
    update();
  }

  void getAppCommission()async {
    isLoading = true;
    update();
    Map<String,dynamic> data = await DioHelper.appCommission();
    appCommission = data['data']['commission'];
    update();
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
}
