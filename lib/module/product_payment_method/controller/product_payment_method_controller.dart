import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/module/home/model/home_model.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';
import 'package:gold_shop/module/product_payment_method/model/product_payment_method_model.dart';

import '../../../core/network/dio_helper.dart';
import '../view/product_payment_method_view.dart';

class ProductPaymentMethodController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool inPerson = true;
  bool withMediatorShop = false;
  bool mediatorShopBetween = false;
  bool mediatorShopFromPlatform = false;
  bool privacyCheck = true;
  TextEditingController firstPhoneNumberController = TextEditingController();
  int phoneNumberCount = 1;
  List<StoresModel> storesModel=[];
  List<String> countries=[];
  List<CitiesModel> cities=[];
  String selectedCountry = AppWord.chooseCountry;
  String selectedCity = AppWord.chooseCity;
   int? addressId;
  int? deliveryMethod = 1;
  int? selectedStoreId;
  int? selectedStore;
  bool isLoading  =false;

  // void addPhoneNumber(){
  //   phoneNumberCount<3?phoneNumberCount ++:phoneNumberCount = 3;
  //   if ( phoneNumberCount > 1 ){
  //    if(phoneNumberCount == 2){
  //      secondPhoneNumberController = TextEditingController();
  //      update();
  //    }else{
  //      thirdPhoneNumberController = TextEditingController();
  //      update();
  //    }
  //   }
  //   update();
  // }
  // void removePhoneNumber(){
  //   phoneNumberCount>1?phoneNumberCount --:phoneNumberCount = 1;
  //   if ( phoneNumberCount >= 1){
  //   if(phoneNumberCount == 2){
  //     thirdPhoneNumberController = null;
  //     update();
  //   }else{
  //     secondPhoneNumberController = null;
  //     thirdPhoneNumberController = null;
  //     update();
  //   }
  //   }
  //   update();
  // listImagePath.forEach((element) async {
  //   tmp.add(await dio.MultipartFile.fromFile(element.path));

void addProduct({
  required List<File> images,
  required String descriptionController,
  required double weightController,
  required String carat,
  required int subcategoryId,
  required double currentGoldPriceController,
  required double profitController,
   double? additionController,
   String? additionDescriptionController,
  required String manufacturerController,
  required int toggle,
  required int productType,
  // required int discountToggle,
   // double? discountValueController,
   // String? offerDescriptionController,
}) async {
   await DioHelper.store(
    images: images,
    description: descriptionController,
    weight: weightController,
    carat: carat,
    subcategoryId: subcategoryId,
    currentGoldPrice: currentGoldPriceController,
    profit: profitController,
    addition: additionController,
    details: additionDescriptionController,
    productType: productType,
    toggle: toggle,
    deliveryType: deliveryMethod,
    phoneNumber: [firstPhoneNumberController.text],
    stores: [selectedStoreId??{}],
     addressId: addressId,
  ).then((value) {
    if(value['message'] == 'The selected delivery type is invalid.'){
      Get.back();
      ControllerSnackBar(errorMessage: AppWord.warning,errorTitle: AppWord.chooseDeliverMethod,);
      update();
    }
    if (value['message'] == 'Product created successfully.'){
    Get.offAll(const MainScreen(),transition: Transition.fade,duration: const Duration(milliseconds: 700));
    ControllerSnackBar(errorMessage: AppWord.warning,);
    update();
    }
    else{
      Get.back();
      ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.checkInternet,);
      update();
    }
   });
  update();
}

  // int deliveryMethod(){
  //   if (inPerson == true && mediatorShopBetween == false && mediatorShopFromPlatform == false){
  //     return 1 ;
  //   }else if (inPerson == false && mediatorShopBetween == true && mediatorShopFromPlatform == false){
  //     return 2 ;
  //   }else if(inPerson == false && mediatorShopBetween == false && mediatorShopFromPlatform == true){
  //     return 3 ;
  //   }else{
  //     Get.snackbar(AppWord.warning, 'Choose delivery method');
  //     return 0 ;
  //   }
  // }


  // List<String> phoneNumbers(){
  //   if (phoneNumberCount == 1){
  //     return [firstPhoneNumberController.text];
  //   }else if(phoneNumberCount == 2){
  //     return [firstPhoneNumberController.text,secondPhoneNumberController!.text];
  //   }else if(phoneNumberCount == 3){
  //     return [firstPhoneNumberController.text,secondPhoneNumberController!.text,thirdPhoneNumberController!.text];
  //   }else{
  //     return [];
  //   }
  // }


void getStores()async{
   Map <String,dynamic> data = await DioHelper.getStores();
   data['data']['data'].forEach((element){storesModel.add(StoresModel.fromJson(json: element));});
   update();
}

void getCountries()async{
    await DioHelper.getCountry().then((value) {
      if(value!=null||value.isNotEmpty){
        value['data'].forEach((element){countries.add(element);});
      }else{
        Get.snackbar(AppWord.warning, AppWord.checkInternet);
      }
      update();
    });
}

void getCities({required String country})async{
    await DioHelper.getCities(country: country).then((value) {
      if(value!=null||value['data'].isNotEmpty){
        value['data'].forEach((element){cities.add(CitiesModel.fromJson(json: element));});
      }else{
        Get.snackbar(AppWord.warning, AppWord.checkInternet);
      }
      update();
    });
}

@override
  void onInit() {
    getCountries();
    getStores();
    super.onInit();
  }
}
