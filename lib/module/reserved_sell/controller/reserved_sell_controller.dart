import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/texts/words.dart';
import '../../category_products/model/category_products_model.dart';

class ReservedSellController extends GetxController {
  bool isLoading = true;
  bool isBannersEmpty = true;
  bool isSubcategoryLoading = true;
  ProfileProductSellsModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS = [];
  int appCommission = 0;

  CameraPosition? position;
  GoogleMapController? mapController;
  MarkerEntity? marker;
  TextEditingController sellingConfirmationController = TextEditingController();




  void subcategoryADVS({required int subcategoryId}) async {
    isSubcategoryLoading = true ;
    update();
    Map<String, dynamic> data = await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));});
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    isSubcategoryLoading = false;
    update();
  }

  void getProductDetails({required int productId})async{
    isLoading= true;
    getAppCommission();
    update();
    Map<String,dynamic> data = await DioHelper.profileListsShowProduct(productId: productId);
    model = ProfileProductSellsModel.fromJson(json: data['data']);
    subcategoryADVS(subcategoryId: model!.subcategoryId);
    position = CameraPosition(target:  model!.location.toLatLng,zoom: 10);
    marker = MarkerEntity.fromMarkerInfo(info: MarkerInfo(markerId: model!.id.toString(), title: '', subTitle: '', location: model!.location));
    isLoading = false;
    update();
  }

  void confirmSellingProcess({required int productId})async{
   if (sellingConfirmationController.text.isNotEmpty){
     Map<String ,dynamic > data = await DioHelper.orderSale(code: sellingConfirmationController.text,productId: productId);
     Get.snackbar(AppWord.note, AppWord.productSoldSuccessfully);
     Get.offAll(const MainScreen());
     update();
   }else{
     Get.snackbar(AppWord.warning, AppWord.theFieldShouldNotBeEmpty);
   }
     update();
   }


  void getAppCommission()async {
    Map<String,dynamic> data = await DioHelper.appCommission();
    appCommission = data['data']['commission'];
    update();
  }
}