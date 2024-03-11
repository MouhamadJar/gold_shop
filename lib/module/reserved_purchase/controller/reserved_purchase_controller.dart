import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../category_products/model/category_products_model.dart';

class ReservedPurchaseController extends GetxController {
  bool isLoading  = true;
  bool isBannersEmpty = true;
  ProfileProductPurchasesModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS=[];
  dynamic appCommission;
  CameraPosition? position;
  MarkerEntity? marker;
  GoogleMapController? mapController;


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
    model = ProfileProductPurchasesModel.fromJson(json: data['data']);
    subcategoryADVS(subcategoryId: model!.subcategoryId);
    position = CameraPosition(target: model!.location!.toLatLng,zoom:  10);
    marker = MarkerEntity.fromMarkerInfo(info: MarkerInfo(location: model!.location!,markerId: model!.id.toString(),title: '',subTitle: ''));
    isLoading = false;
    update();
  }


  void getAppCommission()async{
    Map<String,dynamic> data = await DioHelper.appCommission();
    appCommission = data['data']['commission'];
    update();
  }

}