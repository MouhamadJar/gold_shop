import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/buy_order/model/buy_order_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BuyOrderController extends GetxController {
  bool isLoading = true;
  BuyOrderModel? buyOrderModel;
  CameraPosition? position;
  GoogleMapController? mapController;
  MarkerEntity? marker;

  void getBuyOrder({required int orderId}) async {
    Map<String, dynamic> data = await DioHelper.buyOrder(orderId: orderId);
    print(data.toString());
    buyOrderModel = BuyOrderModel.fromJson(json: data['data']);
    position = CameraPosition(target: buyOrderModel!.location.toLatLng, zoom: 10);
    marker = MarkerEntity.fromMarkerInfo(
      info: MarkerInfo(
          markerId: buyOrderModel!.sellerId.toString(),
          title: '',
          subTitle: '',
          location: buyOrderModel!.location),
    );
    isLoading = false;
    update();
  }
}
