import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/network/dio_helper.dart';
import '../../../../../core/texts/words.dart';
import '../model/edit_product_model.dart';

class EditProductController extends GetxController {
  bool isLoading = true;

  EditProductModel? editProductModel;
  List<SubCategoryADVSModel> subcategoriesADVS = [];
  bool isBannersEmpty = true;
  String manufacturer = '';
  dynamic weight = 0;
  String carat = '_k';
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController caratController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  void getProductDetails({required String productCode}) async {
    isLoading = true;
    update();
    await DioHelper.sendCode(code: productCode).then((value) {
      if (value['status'] == false) {
        isLoading = true;
        Get.back();
        Get.snackbar(AppWord.warning, AppWord.codeNotCorrect);
        update();
      }else {
        isLoading = false;
        editProductModel = EditProductModel.fromJson(json: value['data']);
        if (manufacturerController.text.isEmpty ||
            manufacturerController.text == '') {
          manufacturer = editProductModel!.manufacturer;
          update();
        }
        if (caratController.text.isEmpty || caratController.text == '') {
          carat = editProductModel!.carat;
          update();
        }
        if (weightController.text.isEmpty || weightController.text == '') {
          weight = editProductModel!.weight;
          update();
        }
        subcategoryADVS(subcategoryId: editProductModel!.subcategoryId);
        update();
      }
    });
  }

  void subcategoryADVS({required int subcategoryId}) async {
    Map<String, dynamic> data =
        await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {
      subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));
    });
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

  void sendReport() async {
    noteController.text.isEmpty?noteController.text=AppWord.empty:noteController.text=noteController.text;
    await DioHelper.hisServiceCheck(
        note: noteController.text,
        carat: caratController.text,
        weight: weightController.text,
        manufacturer: manufacturerController.text,
    productId: editProductModel!.productId).then((value) {
      if (value['message']== 'Report has already been stored.'){
        Get.snackbar(AppWord.warning, AppWord.youCantSendMoreThanReportForAnyProduct);
        update();
      }
    });
    update();
  }

  void updateProduct() async {
    await DioHelper.hisServiceUpdate(
        note: noteController.text,
        carat: caratController.text,
        weight: weightController.text,
        manufacturer: manufacturerController.text,
    productId: editProductModel!.productId).then((value) {
    });
    Get.back();
    Get.snackbar(AppWord.done, '');
    update();
  }

}
