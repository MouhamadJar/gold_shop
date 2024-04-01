import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/location_service/geocoding_service.dart';
import '../../../core/location_service/location_entity.dart';
import '../../../core/location_service/location_model.dart';
import '../../../core/location_service/marker_entity.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/image_handler.dart';
import '../../main/user/view/main_screen_view.dart';
import '../../profile/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  ProfileController profileController = Get.find();

  ///declare variables and controller for each field
  bool zoomed =false;
  File? image;

  late TextEditingController firstNameController;

  late TextEditingController lastNameController;

  late TextEditingController userNameController;

  late TextEditingController emailController;

  late TextEditingController phoneNumberController;

  late String country;
  late String state;
  late String city;
  late String neighborhood;
  late String street;
  LocationEntity location = const LocationGoogleModel(lat: 24.470901, lon: 39.612236);
  Set<Marker> markers = {};
  GeocodingCoordinatesManager geocodingCoordinatesManager = Get.put(GeocodingCoordinatesManager());

  void pickImage() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        image = File(value);
        update();
        Get.snackbar(AppWord.done, '');
        return;
      }
      Get.snackbar(AppWord.warning, AppWord.doNotPickImage);
      return;
    });
  }

  void onGoogleMapTapped(LatLng position) {
    update();
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
    geocodingCoordinatesManager.convertCoordinates(latitude: location.lat, longitude: location.lon).then((value) {
      country = value.city;
      state = value.neighborhood;
      city = value.country;
      neighborhood = value.area;
      street = value.route;
      update();
    });
    location.toString();
    update();
  }

  void editProfile() async {
    DioHelper.updateProfile(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text == profileController.user!.email ? null :emailController.text,
            photo: image,
            longitude: location.lon,
            latitude: location.lat,
            country: country,
            state: state,
            city: city,
            neighborhood: neighborhood,
            street: street)
        .then((value) {
      if (value['errors'] != null) {
        Get.snackbar(AppWord.warning, value['message']);
        return;
      } else {
        Get.offAll(const MainScreen());
        Get.snackbar(AppWord.done, AppWord.editProfile);
        return;
      }
    });
  }

  @override
  void onInit() {
    ///init variables and controller for each field
    firstNameController = TextEditingController(text: profileController.user!.firstName);
    lastNameController = TextEditingController(text: profileController.user!.lastName);
    userNameController = TextEditingController(text: profileController.user!.firstName);
    emailController = TextEditingController(text: profileController.user!.email);
    phoneNumberController = TextEditingController(text: profileController.user!.phoneNumber);

    country = profileController.user!.country;
    state = profileController.user!.state;
    city = profileController.user!.city;
    neighborhood = profileController.user!.neighborhood;
    street = profileController.user!.street;
    super.onInit();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
