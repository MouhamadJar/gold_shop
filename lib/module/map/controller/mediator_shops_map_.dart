import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/location_entity.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MediatorShopsMapController extends GetxController {
  WebViewController webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://maps.google.com/?q=24.72375,47.4819908'));

  CameraPosition initialCameraPosition = CameraPosition(
    target: const LocationEntity(lon:46.738586 , lat:24.774265 ).toLatLng,
    zoom: 10,
  );
  MarkerInfo markerInfo = const MarkerInfo(
    markerId: 'markerId',
    title: 'title',
    subTitle: 'subTitle',
    location: LocationEntity(lon: 39.612236, lat:  24.470901),
  );

  late MarkerEntity markerEntity;
  @override
  void onInit() {
    ///Fuck
    markerEntity = MarkerEntity.fromMarkerInfo(info: markerInfo);
    super.onInit();
  }
}
