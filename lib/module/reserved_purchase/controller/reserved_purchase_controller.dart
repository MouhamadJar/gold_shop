import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:gold_shop/module/product_payment_method/model/product_payment_method_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/texts/words.dart';
import '../../category_products/model/category_products_model.dart';

class ReservedPurchaseController extends GetxController {
  bool isLoading  = true;
  bool isBannersEmpty = true;
  ReservedPurchaseModel? model;
  List<SubCategoryADVSModel> subcategoriesADVS=[];
  CameraPosition? position;
  MarkerEntity? marker;
  GoogleMapController? mapController;
  String productType = '';
  List<StoresModel>? storesModel;
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
    model = ReservedPurchaseModel.fromJson(json: data['data'],deliveryType: data['data']['product']['delivery_type']);
    print(model!.orderId.toString());
    if (model!.productType=='1'){
      productType = AppWord.news;
    }if(model!.productType == '2'){
      productType = AppWord.used;
    }else{
      productType = AppWord.likeNew;
    }
    subcategoryADVS(subcategoryId: model!.subcategoryId);
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
    update();
  }

// void  getStoresForProduct()async{
//     await DioHelper.getStoresForProduct(productId: model!.id).then((value) {
//       print(value.toString());
//       if (value['data']['data'].isEmpty||value['data']['data']== null){
//         ControllerSnackBar(errorMessage: AppWord.noStoresInThisPlace,);
//       }else{
//         value['data']['data'].foEach((element){storesModel!.add(StoresModel.fromJson(json: element));});
//
//       }
//     });
//     update();
// }

}