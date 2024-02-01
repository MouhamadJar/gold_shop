import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../category_products/model/category_products_model.dart';

class SoldProductController extends GetxController{
  bool isLoading  = true;
  bool isBannersEmpty = true;
  ProfileProductPurchasesModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS=[];
  List <int> subcategoryId = [];

  TextEditingController buyerMessageController = TextEditingController();
  TextEditingController serviceMessageController = TextEditingController();
  int? buyerStars;
  int? serviceStars;

  void subcategoryADVS({required int subcategoryId}) async {
    Map<String, dynamic> data = await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));});
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

  void getProductDetails({required int productId})async{
    isLoading= true;
    update();
    Map<String,dynamic> data = await DioHelper.profileListsShowProduct(productId: productId);
    model = ProfileProductPurchasesModel.fromJson(json: data['data']);
    isLoading = false;
    subcategoryADVS(subcategoryId: model!.subcategoryId);
    update();
  }

  void rateForSeller({required int productId})async{
    Map<String ,dynamic> data = await DioHelper.rateBySeller(
        buyerRating: buyerStars!,
        buyerMessage: buyerMessageController.text,
        serviceRating: serviceStars!,
        serviceMessage: serviceMessageController.text, productId: productId);
    if(data['message']== 'rated successfully.'){
      Get.back();
      Get.snackbar(AppWord.done, '${AppWord.rateVendor} ${AppWord.done}');}
    else{
      Get.back();
      Get.snackbar(AppWord.note, AppWord.youCantRateMoreThanOneTime);
    }
  update();

  }
}