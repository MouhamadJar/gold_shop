import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/location_service/location_entity.dart';
import '../../../../core/location_service/location_model.dart';
import '../../../../core/location_service/marker_entity.dart';
import '../../model/user/user_signup_model.dart';

class RegisterMediatorShopController extends GetxController {
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<TextEditingController> phoneControllers = [
    TextEditingController(),
  ];
  String country = 'syria';
  String state = 'state';
  String city = 'city';
  String neighborhood = 'neighborhood';
  String street = 'street';
  LocationEntity location =
      const LocationGoogleModel(lat: 24.470901, lon: 39.612236);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CameraPosition position =
      const CameraPosition(target: LatLng(24.470901, 39.612236), zoom: 10);

  UserSignupModel? model;
  Set<Marker> markers = {};

  void register() async {
    List<String> numbers = [];
    for (var element in phoneControllers) {
      numbers.add(element.text);
    }
    isLoading = true;
    update();
    await DioHelper.registerStore(
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      password: passwordController.text,
      latitude: 0.0,
      longitude: 0.0,
      country: country,
      state: state,
      city: city,
      neighborhood: neighborhood,
      street: street,
      numbers: numbers,
      cost: serviceController.text,
    ).then((value) async {
      if (value['errors'] == null) {
        isLoading = false;
        update();
        await StorageHandler().setToken(value['data']['token']);
      } else {
        isLoading = false;
        update();
        Get.snackbar(AppWord.warning, value['message']);
      }
    });
  }

  void onGoogleMapTapped(LatLng position) {
    location = LocationGoogleModel.fromLatLon(position);
    markers = {
      MarkerEntity.fromMarkerInfo(
        info: MarkerInfo(
          markerId: 'markerId',
          title: 'You Location',
          subTitle: 'You are here',
          location: location,
        ),
      ),
    };
    location.toString();
    update();
  }
}
