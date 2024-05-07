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
  ReservedSellModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS = [];
  int appCommission = 0;  CameraPosition? position;
  MarkerEntity? marker;
  GoogleMapController? mapController;
  String productType = '';
  bool isMapExisted = false;
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
    model = ReservedSellModel.fromJson(json: data['data'],deliveryType: data['data']['product']['delivery_type']);
    if (model!.productType=='1'){
      productType = AppWord.news;
    }if(model!.productType == '2'){
      productType = AppWord.used;
    }else{
      productType = AppWord.likeNew;
    }
    if (model!.deliveryType == '2'){
      if(data['data']['receiving_location']!=null){
        isMapExisted =true ;
        position = CameraPosition(target: model!.selectedLocation!.toLatLng, zoom: 10);
        marker = MarkerEntity.fromMarkerInfo(
            info: MarkerInfo(
                location: model!.selectedLocation!,
                markerId: model!.id.toString(),
                title: '',
                subTitle: ''));
        update();
      }else{
        isMapExisted = isMapExisted = false;
        ControllerSnackBar(errorMessage: AppWord.checkInternet);
        update();
      }
    }
    subcategoryADVS(subcategoryId: model!.subcategoryId);
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