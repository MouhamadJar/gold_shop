import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/authentication/model/user/user_signup_model.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';

import '../../../../core/storage_handler/storage_handler.dart';

class UserSignupController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
   double latitude=1;
   double longitude=1;
   String country='';
   String state='';
   String city='';
   String neighborhood='';
   String street='';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

   UserSignupModel? model;

  void signup({
    required double latitude,
    required double longitude,
    required String country,
    required String state,
    required String city,
    required String neighborhood,
    required String street,
  }) async {
    Map<String, dynamic> result = await DioHelper.register(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        password: passwordController.text,
        latitude: latitude,
        longitude: longitude,
        country: country,
        state: state,
        city: city,
        neighborhood: neighborhood,
        street: street);
    await StorageHandler().setToken(model!.token);
    await StorageHandler().setUserId(model!.userId.toString());
    model = UserSignupModel.fromJson(json: result['data']);
    Get.to(const MainScreen(),transition: Transition.rightToLeft, duration: const Duration(milliseconds: 700));
  }
}
