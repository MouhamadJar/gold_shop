import 'dart:io';

import 'package:get/get.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/image_handler.dart';
import '../../category_products/model/category_products_model.dart';
import '../../main/user/view/main_screen_view.dart';

class PutAsidePurchaseController extends GetxController {
  bool isLoading  = true;
  bool isBannersEmpty = true;
  ProfileProductPutAsidePurchasesModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS=[];
  dynamic appCommission ;
  File? image;

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
    getAppCommission();
    Map<String,dynamic> data = await DioHelper.profileListsShowProduct(productId: productId);
    model = ProfileProductPutAsidePurchasesModel.fromJson(json: data['data']);
    isLoading = false;
    subcategoryADVS(subcategoryId: model!.subcategoryId);
    update();
  }


  void getAppCommission()async{
    Map<String,dynamic> data = await DioHelper.appCommission();
    appCommission = data['data']['commission'];
    update();
  }


  void pickImage() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        image = File(value);
        update();
        Get.snackbar(AppWord.done, '');
        return;
      }
      Get.snackbar(AppWord.warning, AppWord.doNotPickImage);
      return;
    });
  }

  void uploadNotificationImage()async{
    await DioHelper.notificationImage(orderId: model!.orderId, image: image!.path).then((value) {
      if (value['errors'] != null) {
        Get.snackbar(AppWord.warning, value['message']);
        return;
      } else {
        Get.offAll(const MainScreen());
        Get.snackbar(AppWord.done, AppWord.notificationUploadedSuccessfully);
        return;
      }
    });
    update();
  }
}