import 'dart:io';

import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/components/components.dart';
import '../../../core/location_service/marker_entity.dart';
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
  String productType='';  CameraPosition? position;
  MarkerEntity? marker;
  GoogleMapController? mapController;
  bool isMapExisted = false;
  dynamic appCommission ;
  File? image;

  void subcategoryADVS({required int subcategoryId}) async {
    Map<String, dynamic> data = await DioHelper.subcategoryADVS(subcategoryId: subcategoryId);
    data['data'].forEach((element) {subcategoriesADVS.add(SubCategoryADVSModel.fromJson(json: element));});
    subcategoriesADVS.isEmpty ? isBannersEmpty : isBannersEmpty = false;
    update();
  }

  void getProductDetails({required int productId})async{
    isLoading= true;
    update();
    getAppCommission();
    Map<String,dynamic> data = await DioHelper.profileListsShowProduct(productId: productId);
    model = ProfileProductPutAsidePurchasesModel.fromJson(json: data['data'],deliveryType: data['data']['product']['delivery_type']);
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
        ControllerSnackBar(errorMessage: AppWord.done);
        return;
      }
      ControllerSnackBar(errorMessage: AppWord.doNotPickImage,errorTitle: AppWord.warning);
      return;
    });
  }

  void uploadNotificationImage()async{
    await DioHelper.notificationImage(orderId: model!.orderId, image: image!.path).then((value) {
      if (value['errors'] != null) {
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: value['message']);
        return;
      } else {
        Get.offAll(const MainScreen());
        ControllerSnackBar(errorMessage: AppWord.notificationUploadedSuccessfully);
        return;
      }
    });
    update();
  }
}