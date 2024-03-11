import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/texts/words.dart';
import '../../category_products/model/category_products_model.dart';

class PurchasedProductController extends GetxController {
  bool isLoading  = true;
  bool isBannersEmpty = true;
  bool isSubcategoryLoading = true;
 ProfileProductPurchasesModel? model;
 List<SubCategoryADVSModel> subcategoriesADVS=[];
 dynamic appCommission = 0 ;
 CameraPosition? position ;
 MarkerEntity? marker;
 GoogleMapController? mapController;


  TextEditingController sellerMessageController = TextEditingController();
  TextEditingController serviceMessageController = TextEditingController();
  TextEditingController productMessageController = TextEditingController();
  int? sellerStars;
  int? productStars;
  int? serviceStars;

  void subcategoryADVS({required int subcategoryId}) async {
    isSubcategoryLoading = true;
    update();
    Map<String, dynamic> data = await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));});
    isSubcategoryLoading = false;
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

 void getProductDetails({required int productId})async{
   isLoading= true;
   update();
   getAppCommission();
   Map<String,dynamic> data = await DioHelper.profileListsShowProduct(productId: productId);
   model = ProfileProductPurchasesModel.fromJson(json: data['data']);
   subcategoryADVS(subcategoryId: model!.subcategoryId);
   position = CameraPosition(target: model!.location!.toLatLng,zoom: 10);
   marker = MarkerEntity.fromMarkerInfo(info: MarkerInfo(location: model!.location!,subTitle: '',title: '',markerId: model!.id.toString()));
   isLoading = false;
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
    update();

  }


  void getAppCommission()async{
    Map<String,dynamic> data = await DioHelper.appCommission();
    appCommission = data['data']['commission'];
    update();
  }
  
  void resellRequest({required int orderId})async{
    await DioHelper.restoreOrResale(orderId: orderId).then((value) {
      if(value == null || value.isEmpty){
        Get.snackbar(AppWord.warning, AppWord.checkInternet);
        update();
        return {};
      }else{
        print(model!.orderId.toString());
        Get.offAll(const MainScreen(),transition: Transition.fade,duration:  const Duration(milliseconds: 700));
        Get.snackbar(AppWord.note, 'message');
        update();
        return {};
      }
    });
  }
}
