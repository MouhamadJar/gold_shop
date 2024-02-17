import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

import '../../../core/texts/words.dart';
import '../../category_products/model/category_products_model.dart';

class PurchasedProductController extends GetxController {
  bool isLoading  = true;
  bool isBannersEmpty = true;
 ProfileProductPurchasesModel? model;
 List<SubCategoryADVSModel> subcategoriesADVS=[];


  TextEditingController sellerMessageController = TextEditingController();
  TextEditingController serviceMessageController = TextEditingController();
  TextEditingController productMessageController = TextEditingController();
  int? sellerStars;
  int? productStars;
  int? serviceStars;

  void subcategoryADVS({required int subcategoryId}) async {
    Map<String, dynamic> data = await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));});
    print(subcategoriesADVS.length.toString());
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

 void getProductDetails({required int productId})async{
   isLoading= true;
   update();
   Map<String,dynamic> data = await DioHelper.profileListsShowProduct(productId: productId);
   print(data.toString());
   model = ProfileProductPurchasesModel.fromJson(json: data['data']);
   isLoading = false;
   subcategoryADVS(subcategoryId: model!.subcategoryId);
   update();
 }


  void rateForBuyer({required int productId})async{
    Map<String ,dynamic> data = await DioHelper.rateByBuyer(
        sellerRating: sellerStars!,
        sellerMessage: sellerMessageController.text,
        serviceRating: serviceStars!,
        serviceMessage: serviceMessageController.text,
        productId: productId,
        productRating: productStars!,
        productMessage: productMessageController.text);
    if(data['message']== 'rated successfully.'){
      Get.back();
      Get.snackbar(AppWord.done, '${AppWord.rateVendor} ${AppWord.done}');}
    else{
      Get.back();
      Get.snackbar(AppWord.note, AppWord.youCantRateMoreThanOneTime);
    }
    print(data.toString());
    update();

  }
}
