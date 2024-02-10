import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:gold_shop/module/profile/model/profile_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/network/dio_helper.dart';

class ProfileController extends GetxController {
  bool isLoading = true;
  bool isLoadingPurchases = true;
  bool isLoadingSells = true;
  bool isLoadingMyProducts = true;
  CameraPosition? position;
  GoogleMapController? mapController ;
  MarkerEntity? marker;
  Map<String, dynamic> model = {};
  ProfileModel? user;
  List<Map<String, dynamic>> myPurchases = [];
  List<Map<String, dynamic>> mySells = [];
  List<Map<String, dynamic>> myProducts = [];

  void getProfile() async {
    Map<String, dynamic> data = await DioHelper.showProfile();
    model = data['data'];
    user = ProfileModel.fromJson(json: model);
    position = CameraPosition(target: user!.location.toLatLng, zoom: 10);
    marker = MarkerEntity.fromMarkerInfo(
      info: MarkerInfo(
        markerId: user!.id.toString(),
        title: 'your location',
        subTitle: 'You are here',
        location: user!.location,
      ),
    );
    isLoading = false;
    update();
  }

  void getPurchases() async {
    Map<String, dynamic> data = await DioHelper.profilePurchasesList();
    data['data'].forEach((element) {
      myPurchases.add(element);
    });
    isLoadingPurchases = false;
    update();
  }

  void getSells() async {
    Map<String, dynamic> data = await DioHelper.profileSalesList();
    data['data'].forEach((element) {
      mySells.add(element);
    });
    isLoadingSells = false;
    update();
  }

  void getMyProducts() async {
    Map<String, dynamic> data = await DioHelper.profileMyProductsList();
    data['data'].forEach((element) {myProducts.add(element);});
    isLoadingMyProducts = false;
    update();
  }
}
