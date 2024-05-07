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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool additionCheck = false;
  bool isPinned = false;
  bool isLoading = true;
  bool checkSubId = false;
  bool newProduct = false;
  bool likeNewProduct = false;
  bool usedProduct = false;
  int? productType;
  String categoriesTitle = AppWord.productCategory;
  String subcategoriesTitle = AppWord.productClassification;
  String calibers = AppWord.caliber;
  int caliberPrice = 0;
  int appCommission = 0;

  List<CategoriesModel> categoriesModel = [];
  List<ClassificationCategoriesModel> subcategoriesModel = [];

  List<DIO.MultipartFile> tmp = [];
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController additionController = TextEditingController();
  TextEditingController additionDescriptionController = TextEditingController();
  TextEditingController appCommissionController = TextEditingController();
  TextEditingController totalGramPriceController = TextEditingController();
  TextEditingController? totalProductPriceController;
  TextEditingController profitController = TextEditingController();
  TextEditingController currentGoldPriceController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController caliberPriceValueController = TextEditingController();
  TextEditingController offerDescriptionController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();
  int discountToggle = 0;
  int? subcategoryId;
  int toggle = 0;
  double totalGramPrice = 0;
  double weight = 0;
  double profit = 0;
  double addition = 0;
  double discountValue = 0;
  String manufacturerType = 'local';

  List<File>? listImagePath =[];
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
    categoriesModel.clear();
    update();
    Map<String, dynamic> categories = await DioHelper.getAllCategories();
    categories['data']['data'].forEach((element) {
      categoriesModel.add(CategoriesModel.frmJson(json: element));
    });
    isLoading = false;
    update();
  }

  void getSubcategories({required int categoryId}) async {
    Map<String, dynamic> subcategories = await DioHelper.getAllSubCategories(categoryId: categoryId);
    subcategories['data']['data'].forEach((element) {
      subcategoriesModel.add(ClassificationCategoriesModel.fromJson(json: element));
    });
    update();
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
        listImagePath!.clear();
        for (XFile file in images!) {
          listImagePath!.add(File(file.path));
        }
        listImagePath!.forEach((element) async {
              tmp.add(await DIO.MultipartFile.fromFile(element.path));
            });
        Get.snackbar(AppWord.done, '');
        update();
      }
    });

  }
  void addMoreImages() async {
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
        listImagePath!.forEach((element) async {
              tmp.add(await DIO.MultipartFile.fromFile(element.path));
            });
        Get.snackbar(AppWord.done, '');
        update();
      }
    });

  }

  void getAllCaratPrices()async{
    await DioHelper.getAllCaratPrices().then((value) {
      update();
      caliberPrice = value['data'][calibers].toInt();
    });
    update();
  }

  // void getAppCommission()async {
  //   isLoading = true;
  //   update();
  //   Map<String,dynamic> data = await DioHelper.appCommission();
  //   print(data.toString());
  //   appCommission = data['data']['commission'];
  //   update();
  // }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
}
