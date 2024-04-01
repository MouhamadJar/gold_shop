import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/module/authentication/model/user/user_login_model.dart';
import 'package:gold_shop/module/authentication/view/check_code_screen.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';

import '../../../main/mediator_shop/signature/view/mediator_shop_view.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginModel? model;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Map<String, dynamic> result = {};
  bool loader = true;
  bool hidePassword = false;

  void login() async {
    await DioHelper.login(
            phoneNumber: phoneController.text,
            password: passwordController.text).then((value) async {
          result = value;
          update();
          if (result['message']=='User login successfully.'){
            model = LoginModel.fromJson(json: result['data']);
            await StorageHandler().setUserId(model!.userId.toString());
            Get.log(StorageHandler().userId);
            await StorageHandler().setToken(model!.token);
            if (model!.photo != null) {
              await StorageHandler().setProfilePhoto(baseUrlImages + model!.photo!);
            }
            if (model!.verified == 1) {
              await StorageHandler().setVerification(model!.verified.toString());
            }
            await StorageHandler().setUserName(model!.name);
            await StorageHandler().setRole('user');
            loader = false;
            Get.offAll(const MainScreen(),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 700));

          }
          else if(result['message']== 'Unauthorised.'){
            Get.back();
            Get.snackbar(AppWord.warning, AppWord.wrongPhoneNumberOrPassword);
            update();
          }
          else{
            Get.back();
            Get.snackbar(AppWord.warning, AppWord.checkInternet);
            update();
          }
    });
  }
}
