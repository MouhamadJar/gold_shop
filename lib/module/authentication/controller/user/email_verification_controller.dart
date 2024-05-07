import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/module/authentication/model/user/user_signup_model.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../../../core/storage_handler/storage_handler.dart';
import '../../../main/user/view/main_screen_view.dart';

class EmailVerificationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState>  formKey  =GlobalKey<FormState>();
  UserSignupModel? model;

  void verify() async {
    await DioHelper.verifyEmail(
      email: emailController.text,
      code: otpController.text,
    ).then((value) {
      if(value['message']=='Sorry your email cannot be identified.'){
        Get.back();
        ControllerSnackBar(errorMessage: AppWord.pleaseMakeSureYouEnteredTheSameEmailOrOTP);
      }else{
        Get.back();
        model = UserSignupModel.fromJson(json: value['data']);
         StorageHandler().setToken(model!.token);
         StorageHandler().setUserId(model!.userId.toString());
         StorageHandler().setUserName(model!.name.toString());
         StorageHandler().setVerification(model!.verified.toString());
         StorageHandler().setRole('user');
        Get.offAll(const MainScreen(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 700));
      }
    });

    update();
  }
}
