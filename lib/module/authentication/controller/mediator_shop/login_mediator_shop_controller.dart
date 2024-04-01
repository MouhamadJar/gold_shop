import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/storage_handler/storage_handler.dart';
import '../../../main/mediator_shop/signature/view/mediator_shop_view.dart';
import '../../model/user/user_login_model.dart';

class LoginMediatorShopController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, dynamic> result = {};
  LoginModel? model;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = false;


  void login() async {
    await DioHelper.loginMediatorShop(
        userName: userNameController.text, password: passwordController.text).then((value) async {
          result = value;
          update();
          if(result['message'] == 'Store login successfully.'){
            Get.back();
            model = LoginModel.fromJson(json: value['data']);
            await StorageHandler().setMediatorToken(model!.token);
            await StorageHandler().setMediatorId(model!.userId.toString());
            if (model!.photo != null) {
              await StorageHandler().setMediatorProfilePhoto(baseUrlImages + model!.photo!);
            }
            if (model!.verified == 1) {
              await StorageHandler().setMediatorVerification(model!.verified.toString());
            }
            await StorageHandler().setMediatorName(model!.name);
            await StorageHandler().setRole('shop');
            Get.offAll(const MediatorShopHome(),transition: Transition.fade,duration: const Duration(milliseconds: 700));
            update();
          }else if (result['message'] == 'Unauthorised.'){
            Get.back();
            Get.snackbar(AppWord.warning,AppWord.wrongUserNameOrPassword);
            update();
          }else{
            Get.back();
            Get.snackbar(AppWord.warning, AppWord.checkInternet);
            update();
          }
    });
  }
}
