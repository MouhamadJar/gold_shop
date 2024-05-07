import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../category_products/model/category_products_model.dart';

class SoldProductController extends GetxController{
  bool isLoading  = true;
  bool isBannersEmpty = true;
  ProfileProductSellsModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS=[];
  List <int> subcategoryId = [];
  dynamic appCommission = 0;

  TextEditingController buyerMessageController = TextEditingController();
  TextEditingController serviceMessageController = TextEditingController();
  int? buyerStars;
  int? serviceStars;
  CameraPosition? position;
  MarkerEntity? marker;
  GoogleMapController? mapController;
  String productType = '';
  bool isMapExisted = false;

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
    model = ProfileProductSellsModel.fromJson(json: data['data'],deliveryType: data['data']['product']['delivery_type']);
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


  void getAppCommission()async{
    Map<String,dynamic> data = await DioHelper.appCommission();
    appCommission = data['data']['commission'];
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