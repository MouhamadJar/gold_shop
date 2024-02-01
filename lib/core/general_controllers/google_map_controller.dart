import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../location_service/marker_entity.dart';

class AppGoogleMapController extends GetxController{

  CameraPosition? position;
  GoogleMapController? mapController ;


  @override
  void onInit() {
    position = const CameraPosition(target: LatLng(24.470901, 39.612236), zoom: 10);
    super.onInit();
  }
}