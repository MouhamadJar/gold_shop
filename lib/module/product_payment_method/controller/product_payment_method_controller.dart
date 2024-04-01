import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';
import 'package:gold_shop/module/product_payment_method/model/product_payment_method_model.dart';

import '../../../core/network/dio_helper.dart';

class ProductPaymentMethodController extends GetxController {
  bool inPerson = true;
  bool withMediatorShop = false;
  bool mediatorShopBetween = false;
  bool mediatorShopFromPlatform = false;
  bool privacyCheck = true;
  TextEditingController firstPhoneNumberController = TextEditingController(text: '099487156');
  TextEditingController? secondPhoneNumberController;
  TextEditingController? thirdPhoneNumberController;
  int phoneNumberCount = 1;
  List<StoresModel> storesModel=[];
  int? selectedStoreId;
  bool isLoading  =false;

  void addPhoneNumber(){
    phoneNumberCount<3?phoneNumberCount ++:phoneNumberCount = 3;
    if ( phoneNumberCount > 1 ){
     if(phoneNumberCount == 2){
       secondPhoneNumberController = TextEditingController();
       update();
     }else{
       secondPhoneNumberController = TextEditingController();
       thirdPhoneNumberController = TextEditingController();
       update();
     }
    }
    update();
  }
  void removePhoneNumber(){
    phoneNumberCount>1?phoneNumberCount --:phoneNumberCount = 1;
    if ( phoneNumberCount >= 1){
    if(phoneNumberCount == 2){
      thirdPhoneNumberController = null;
      update();
    }else{
      secondPhoneNumberController = null;
      thirdPhoneNumberController = null;
      update();
    }
    }
    update();
  }

  int deliveryMethod(){
    if (inPerson == true && mediatorShopBetween == false && mediatorShopFromPlatform == false){
      return 1 ;
    }else if (inPerson == false && mediatorShopBetween == true && mediatorShopFromPlatform == false){
      return 2 ;
    }else if(inPerson == false && mediatorShopBetween == false && mediatorShopFromPlatform == true){
      return 3 ;
    }else{
      Get.snackbar(AppWord.warning, 'Choose delivery method');
      return 0 ;
    }
  }

  List<String> phoneNumbers(){
    if (phoneNumberCount == 1){
      return [firstPhoneNumberController.text];
    }else if(phoneNumberCount == 2){
      return [firstPhoneNumberController.text,secondPhoneNumberController!.text];
    }else if(phoneNumberCount == 3){
      return [firstPhoneNumberController.text,secondPhoneNumberController!.text,thirdPhoneNumberController!.text];
    }else{
      return [];
    }
  }


  // listImagePath.forEach((element) async {
  //   tmp.add(await dio.MultipartFile.fromFile(element.path));
  // });

void addProduct({
  required List<File> images,
  required String descriptionController,
  required String ageController,
  required double weightController,
  required String carat,
  required int subcategoryId,
  required double currentGoldPriceController,
  required double profitController,
   double? additionController,
   String? additionDescriptionController,
  required String manufacturerController,
  required String manufacturerType,
  required int toggle,
  required int discountToggle,
   double? discountValueController,
   String? offerDescriptionController,
}) async {
   await DioHelper.store(
    images: images,
    description: descriptionController,
    age: ageController,
    weight: weightController,
    carat: carat,
    subcategoryId: subcategoryId,
    currentGoldPrice: currentGoldPriceController,
    profit: profitController,
    addition: additionController,
    details: additionDescriptionController,
    manufacturer: manufacturerController,
    manufacturerType: manufacturerType,
    toggle: toggle,
    deliveryType: deliveryMethod(),
    phoneNumber: phoneNumbers(),
    stores: [selectedStoreId??{}],
    discountToggle:  discountToggle,
    discountValue: discountValueController,
    offerDescription: offerDescriptionController,
  ).then((value) {
    print(value.toString());
    if (value['message'] == 'Product created successfully.'){
    Get.snackbar(AppWord.done, '');
    update();
    Get.offAll(const MainScreen(),transition: Transition.fade,duration: const Duration(milliseconds: 700));
    }else{
      Get.back();
      Get.snackbar(AppWord.warning, AppWord.checkAllRequiredFields);
      update();
    }
   });
  update();
}

void getStores()async{
   Map <String,dynamic> data = await DioHelper.storeIndex();
   data['data']['data'].forEach((element){storesModel.add(StoresModel.fromJson(json: element));});
   update();
}
@override
  void onInit() {
    getStores();
    super.onInit();
  }
}
