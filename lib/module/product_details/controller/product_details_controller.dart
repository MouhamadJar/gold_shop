import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/module/product_details/model/product_details_model.dart';

import '../../../core/images/images.dart';
import '../../category_products/model/category_products_model.dart';
import '../../invoice/view/invoice_view.dart';

class ProductDetailsController extends GetxController {

  bool isChecked = false;

  String buttonBackground = AppImages.buttonDarkBackground;

  ProductDetailsModel? model;

  bool isLoading = true;

  List<SubCategoryADVSModel> subcategoriesADVS = [];

  bool isBannersEmpty = true;

  bool putAsideLoading = true;

  PutAsideModel? putAsideModel;

  late AllCaratPrices allCaratPrices;

  String productType = '';

  bool contactUsLoading = false;

  TextEditingController contactUsController = TextEditingController();

  TextEditingController problemController = TextEditingController();

  void checked() {
    if (isChecked) {
      buttonBackground = AppImages.buttonDarkBackground;
      isChecked = !isChecked;
    } else {
      buttonBackground = AppImages.buttonLiteBackground;
      isChecked = !isChecked;
    }
    update();
  }

  void getProductDetails({required int productId}) async {
    Map<String, dynamic> data = await DioHelper.show(productId: productId);
    model = ProductDetailsModel.fromJson(json: data['data']);
    if (model!.productType=='1'){
      productType = AppWord.news;
    }if(model!.productType == '2'){
      productType = AppWord.used;
    }else{
      productType = AppWord.likeNew;
    }
    Get.lazyPut(() => AllCaratPrices());
    allCaratPrices = Get.find();
    allCaratPrices.carat = model!.carat;
    subcategoryADVS(subcategoryId: model!.subcategoryId);
    isLoading = false;
    update();
  }

  void subcategoryADVS({required int subcategoryId}) async {
    Map<String, dynamic> data = await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));});
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

  void reportProblem() async {
    if(problemController.text.isEmpty){
      Get.snackbar('', AppWord.pleaseEnterDescription);
      return;
    }
    bool data = await DioHelper.problemStore(
        description: problemController.text,
        type: 'problem',
        productId: model!.id ?? 1);
    if(data){
      Get.back();
      Get.snackbar('', AppWord.problemCreatedSuccessfully);
    }
  }

  void addProductToPutAside({required int productId})async{
    Map<String,dynamic> data = await DioHelper.ordersOnHold(productId: productId);
      putAsideModel = PutAsideModel.fromJson(json: data['data']);
      Get.back();
    Get.to(Invoice(orderId: putAsideModel!.orderId,),transition: Transition.zoom,duration: const Duration(milliseconds: 500));
      update();
  }

  void contactUsMessage() async {
    isLoading = true;
    update();
    await DioHelper.contactUsStore(description: contactUsController.text
    ).then((value) {
      if (value) {
        Get.back();
        contactUsController.clear();
        isLoading = false;
        update();
        ControllerSnackBar(errorMessage: AppWord.done);
      } else {
        isLoading = false;
        update();
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.checkInternet);
      }
    });
  }

}
