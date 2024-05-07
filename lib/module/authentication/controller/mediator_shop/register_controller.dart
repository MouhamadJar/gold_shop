import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/storage_handler/storage_handler.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/location_service/geocoding_service.dart';
import '../../../../core/location_service/location_entity.dart';
import '../../../../core/location_service/location_model.dart';
import '../../../../core/location_service/marker_entity.dart';
import '../../../../core/utils/image_handler.dart';
import '../../model/user/user_signup_model.dart';

class RegisterMediatorShopController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isChecked = false;
  bool isCommercialUploaded = false;
  bool isLicenseUploaded = false;
  bool isTaxCertificateUploaded = false;
  bool isShopImageUploaded = false;
  bool zoomed = false;
  List<String> numbers =[];
  List<String> phoneNumber =[];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nationalNumberController = TextEditingController();
  TextEditingController commercialRegisterController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController taxCertificateController = TextEditingController();
  File? commercialRegisterImage;
  File? licenseImage;
  File? taxCertificate;
  File? shopImage;
  GeocodingCoordinatesManager geocodingCoordinatesManager =
  Get.put(GeocodingCoordinatesManager());
  String country = 'country';
  String state = 'state';
  String city = 'city';
  String neighborhood = 'neighborhood';
  String street = 'street';
  String area = 'area';
  LocationEntity location = const LocationGoogleModel(lat: 24.470901, lon: 39.612236);
  CameraPosition position = const CameraPosition(target: LatLng(24.470901, 39.612236),);
  UserSignupModel? model;
  Set<Marker> markers = {};

  void pickCommercialRegisterImage() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        commercialRegisterImage = File(value);
        isCommercialUploaded = true;
        update();
        ControllerSnackBar(errorMessage: AppWord.done);
        return;
      }else {
        isCommercialUploaded = false ;
        ControllerSnackBar(errorMessage: AppWord.doNotPickImage);
        update();
      }
      return;
    });
  }

  void pickLicenseImage() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        licenseImage = File(value);
        isLicenseUploaded  = true;
        update();
        ControllerSnackBar(errorMessage: AppWord.done);
        return;
      }
      else{
        isLicenseUploaded = false;
        ControllerSnackBar(errorMessage: AppWord.doNotPickImage);
      update();
      }
      return;
    });
  }
  void pickTaxCertificate() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        taxCertificate = File(value);
        isTaxCertificateUploaded  = true;
        update();
        ControllerSnackBar(errorMessage: AppWord.done);
        return;
      }
      else{
        isTaxCertificateUploaded = false;
        ControllerSnackBar(errorMessage: AppWord.doNotPickImage);
      update();
      }
      return;
    });
  }
  void pickShopImage() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        shopImage = File(value);
        isShopImageUploaded  = true;
        update();
        ControllerSnackBar(errorMessage: AppWord.done);
        return;
      }
      else{
        isShopImageUploaded = false;
        ControllerSnackBar(errorMessage: AppWord.doNotPickImage);
      update();
      }
      return;
    });
  }

  void register() async {
    isLoading = true;
    update();
    if(country == 'country'|| state == 'state'|| city=='city'||neighborhood=='neighborhood'||street== 'street'){
      Get.back();
      ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.selectYourLocation);
      update();
    }else{
      if(licenseImage==null ||commercialRegisterImage == null || taxCertificate == null){
        Get.back();
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.uploadCommercialRegisterAndLicensePics,);
        update();
      } if (shopImage == null ){
        Get.back();
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.uploadShopImage,);
        update();
      }else{
    await DioHelper.registerStore(
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      latitude: location.lat,
      longitude: location.lon,
      country: country,
      state: state,
      city: city,
      neighborhood: neighborhood,
      street: street,
      description: descriptionController.text,
      nationalNumber: nationalNumberController.text,
      commercialRegister: commercialRegisterController.text,
      commercialRegisterImage: commercialRegisterImage!.path,
      license: licenseController.text,
      licenseImage: licenseImage!.path,
      shopImage: shopImage!.path,
      taxNumber: taxCertificateController.text,
      taxAssignmentCertificateImage: taxCertificate!.path
    ).then((value) async {
      if (value['message']== 'The email has already been taken. (and 1 more error)'){
          Get.back();
          ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.takenNumberAndEmail,);
          update();
      }
      if(value['message']== 'The phone number has already been taken.'){
        Get.back();
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.takenNumber,);
        update();
      }
      if(value['message']== 'The email has already been taken.'){
        Get.back();
        Get.snackbar(AppWord.warning, AppWord.takenEmail);
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.takenEmail,);
        update();
      }
       if (value['message'] == 'Store register successfully.') {
        Get.back();
        ControllerSnackBar(errorMessage: AppWord.done,);
        Get.offAll(const MainScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 700));
        update();
      } else {
        Get.back();
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: value['message']);
        update();
      }
    });}
    }
  }

  void onGoogleMapTapped(LatLng position) {
    update();
    location = LocationGoogleModel.fromLatLon(position);
    markers = {MarkerEntity.fromMarkerInfo(
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
      area = value.city;

      update();
    });
    location.toString();
    update();
  }
}
