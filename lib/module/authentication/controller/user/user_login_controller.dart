import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';
import 'package:gold_shop/module/authentication/model/user/user_login_model.dart';
import 'package:gold_shop/module/authentication/view/check_code_screen.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';

class LoginController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginModel? model;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login({
    required String phone,
    required String password,
  })async {
    Map<String , dynamic> result =await DioHelper.login(phoneNumber: phoneController.text, password: passwordController.text);
    model =LoginModel.fromJson(json: result['data']);
    await StorageHandler().setToken(model!.token);
    await StorageHandler().setUserId(model!.userId.toString());
    Get.offAll(const MainScreen(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 700));
  }
}
