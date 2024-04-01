import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/mediator_shop_profile_model.dart';

class MediatorProfileController extends GetxController{
  MediatorShopProfileModel? model ;
  CameraPosition? position ;
  MarkerEntity? marker ;
  GoogleMapController? mapController;
  bool isLoading = true ;
  void getMediatorProfile ()async {
    await DioHelper.showStoreProfile().then((value) {
      print(value.toString());
     model = MediatorShopProfileModel.fromJson(json: value['data'][0]);
     position = CameraPosition(target: model!.location.toLatLng,zoom: 10);
     marker = MarkerEntity.fromMarkerInfo(info: MarkerInfo(location: model!.location,title: 'your location',markerId: model!.userId.toString(),subTitle: 'you are here'));
     isLoading = false;
     update();
    });
    update();
  }
  @override
  void onInit() {
    getMediatorProfile();
    super.onInit();
  }
}