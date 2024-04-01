import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/extention.dart';
import 'package:gold_shop/core/location_service/marker_entity.dart';
import 'package:gold_shop/module/main/mediator_shop/mediator_shop_profile/model/mediator_shop_profile_model.dart';
import 'package:gold_shop/module/main/mediator_shop/product_code/view/product_code_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/colors/colors.dart';
import '../../../../../core/location_service/geocoding_service.dart';
import '../../../../../core/location_service/location_entity.dart';
import '../../../../../core/location_service/location_model.dart';
import '../../../../../core/network/dio_helper.dart';
import '../../../../../core/texts/words.dart';
import '../../../../../core/utils/image_handler.dart';

class MediatorShopEditProfileController extends GetxController {
  bool isLoading = true ;
  bool loader = false ;
  bool zoomed = false;
  MediatorShopProfileModel ? mediatorShopProfileModel;
  late TextEditingController nameController ;
  late TextEditingController emailController ;
  late TextEditingController profitController ;
  late TextEditingController descriptionController ;
  late TextEditingController firstPhoneNumberController;
  TextEditingController? secondPhoneNumberController;
  TextEditingController? thirdPhoneNumberController;
  int phoneNumberCount = 1;
  late MarkerEntity marker ;
  late GoogleMapController mapController;
  late CameraPosition position;
  late String country;
  late String state;
  late String city;
  late String neighborhood;
  late String street;
  LocationEntity location = const LocationGoogleModel(lat: 24.470901, lon: 39.612236);
  Set<Marker> markers = {};
  GeocodingCoordinatesManager geocodingCoordinatesManager = Get.put(GeocodingCoordinatesManager());

  File? image;
  void addPhoneNumber(){
    phoneNumberCount<3?phoneNumberCount ++:phoneNumberCount = 3;
    if ( phoneNumberCount > 1 ){
      if(phoneNumberCount == 2){
        secondPhoneNumberController = TextEditingController();
        update();
      }else{
        secondPhoneNumberController = TextEditingController();
        thirdPhoneNumberController = TextEditingController();
        update();
      }
    }
    update();
  }
  void removePhoneNumber(){
    phoneNumberCount>1?phoneNumberCount --:phoneNumberCount = 1;
    if ( phoneNumberCount >= 1){
      if(phoneNumberCount == 2){
        thirdPhoneNumberController = null;
        update();
      }else{
        secondPhoneNumberController = null;
        thirdPhoneNumberController = null;
        update();
      }
    }
    update();
  }

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
    if(image == null){
      Get.snackbar(AppWord.warning, AppWord.pleaseSelectPhoto);
      update();
    }else{
      Get.dialog(Center(child: CircularProgressIndicator(color: CustomColors.gold,),));
    await DioHelper.updateStoreProfile(
      name: nameController.text,
      email: emailController.text,
      photo: image!,
      latitude:location.lat,
      longitude: location.lon,
      country: country,
      state: state,
      city: city,
      neighborhood: neighborhood,
      street: street,
      numbers: [],
      numbersId: [],
      description: descriptionController.text,
      cost: int.parse(profitController.text),
    ).then((value) {
      if (value['message']=='Store updated successfully.'){
        Get.offAll(const ProductCode(),transition: Transition.zoom,duration: const Duration(milliseconds: 700));
        update();
      }else {
        Get.back();
        update();
      }
    });}
    update();
  }

  void getProfileData()async{
    await DioHelper.showStoreProfile().then((value) {
      mediatorShopProfileModel = MediatorShopProfileModel.fromJson(json: value['data'][0]);
      nameController = TextEditingController(text: mediatorShopProfileModel!.name);
      emailController = TextEditingController(text: mediatorShopProfileModel!.email);
      firstPhoneNumberController = TextEditingController(text: mediatorShopProfileModel!.phoneNumber);
      descriptionController = TextEditingController(text: mediatorShopProfileModel!.description);
      profitController = TextEditingController(text: mediatorShopProfileModel!.cost.toString());
      marker = MarkerEntity.fromMarkerInfo(info: MarkerInfo(subTitle: 'you are here',markerId: mediatorShopProfileModel!.userId.toString(),title: 'Your location',location: mediatorShopProfileModel!.location));
      position = CameraPosition(target: mediatorShopProfileModel!.location.toLatLng,zoom: 10);
      country = mediatorShopProfileModel!.country;
      state = mediatorShopProfileModel!.state;
      city = mediatorShopProfileModel!.city;
      neighborhood = mediatorShopProfileModel!.neighborhood;
      street = mediatorShopProfileModel!.street;
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }
}
