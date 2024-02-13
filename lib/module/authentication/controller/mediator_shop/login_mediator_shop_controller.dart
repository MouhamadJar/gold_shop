import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/storage_handler/storage_handler.dart';
import '../../../main/mediator_shop/signature/view/mediator_shop_view.dart';
import '../../model/user/user_login_model.dart';
import '../../../main/user/view/main_screen_view.dart';

class LoginMediatorShopController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginModel? model;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login({
    required String phone,
    required String password,
  })async {
    Map<String , dynamic> result =await DioHelper.loginMediatorShop(phoneNumber: phoneController.text, password: passwordController.text);
    model =LoginModel.fromJson(json: result['data']);
    await StorageHandler().setToken(model!.token);
    await StorageHandler().setUserId(model!.userId.toString());
    await StorageHandler().setRole('shop');
    Get.offAll(const MediatorShopHome());
   }
}
