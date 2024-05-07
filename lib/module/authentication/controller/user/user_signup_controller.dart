import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_shop/module/authentication/view/check_code_screen.dart';
import 'package:gold_shop/module/authentication/view/user/email_verification_screen.dart';
import 'package:gold_shop/module/authentication/view/user/verify_account_screen.dart';
import 'package:gold_shop/module/product_payment_method/model/product_payment_method_model.dart';
import '../../../../core/components/components.dart';
import '../../../../core/location_service/geocoding_service.dart';
import '../../../../core/texts/words.dart';
import '../../model/user/user_signup_model.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../main/user/view/main_screen_view.dart';
import '../../../../core/location_service/marker_entity.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import '../../../../core/location_service/location_model.dart';
import '../../../../core/storage_handler/storage_handler.dart';
import '../../../../core/location_service/location_entity.dart';

class UserSignupController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String>countries=[];
  List<CitiesModel>cities=[];
  String selectedCountry = AppWord.chooseCountry;
  String selectedCity = AppWord.chooseCity;
  late int addressId;
  bool zoomed = false;
  bool hidePassword = true;
  UserSignupModel? model;
  bool check = false;

  // double latitude = 1;
  // double longitude = 1;
  // String country = 'country';
  // String state = 'state';
  // String city = 'city';
  // String neighborhood = 'neighborhood';
  // // String street = 'street';
  // LocationEntity location = const LocationGoogleModel(lat: 24.470901, lon: 39.612236);
  // CameraPosition position = const CameraPosition(target: LatLng(24.470901, 39.612236), zoom: 10);
  // Set<Marker> markers = {};
  // GeocodingCoordinatesManager geocodingCoordinatesManager = Get.put(GeocodingCoordinatesManager());
  void signup() async {
    if(selectedCountry ==AppWord.chooseCountry){
      Get.back();
      ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.chooseCountry);
    }if (selectedCity== AppWord.chooseCity){
      Get.back();
      ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.chooseCity);
    }
    else{
      await DioHelper.register(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
              phoneNumber: phoneController.text,
              password: passwordController.text,
        description : descriptionController.text,
        addressId: addressId,
      ).then((value) async {
            print(value);
        if(value['message']=='The email has already been taken. (and 1 more error)'){
          Get.back();
          ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.takenNumberAndEmail,);
          update();
        }
        if (value['message'] == 'The email has already been taken.') {
          Get.back();
          ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.takenEmail,);
          return value;
        }
        if (value['message'] == 'The phone number has already been taken.') {
          Get.back();
          ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.takenNumber,);
          return value;
        }
        else {
          Get.back();
          Get.to(const EmailVerificationScreen(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 500));
          return value;
        }
      });}
  }


  void getCountries()async{
    await DioHelper.getCountry().then((value) {
      if(value!=null||value.isNotEmpty){
        value['data'].forEach((element){countries.add(element);});
      }else{
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.checkInternet);
      }
      update();
    });
  }

  void getCities({required String country})async{
    await DioHelper.getCities(country: country).then((value) {
      if(value!=null||value['data'].isNotEmpty){
        value['data'].forEach((element){cities.add(CitiesModel.fromJson(json: element));});
      }else{
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.checkInternet);
      }
      update();
    });
  }

  @override
  void onInit() {
    getCountries();
    super.onInit();
  }


  // void onGoogleMapTapped(LatLng position) {
  //   update();
  //   location = LocationGoogleModel.fromLatLon(position);
  //   markers = {
  //     MarkerEntity.fromMarkerInfo(
  //       info: MarkerInfo(
  //         markerId: 'markerId',
  //         title: 'You Location',
  //         subTitle: 'You are here',
  //         location: location,
  //       ),
  //     ),
  //   };
  //   geocodingCoordinatesManager.convertCoordinates(latitude: location.lat, longitude: location.lon)
  //       .then((value) {
  //     country = value.city;
  //     city = value.area;
  //     state = value.area;
  //     neighborhood = value.neighborhood;
  //     street = value.route;
  //     // area = value.city;
  //     update();
  //   });
  //   location.toString();
  //   update();
  // }
}
