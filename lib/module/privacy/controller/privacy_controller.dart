import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class PrivacyController extends GetxController{
  bool isLoading = true;
  String? privacyText;
  void privacy()async{
    Map<String,dynamic> data = await DioHelper.privacy();
    privacyText = data['data']['privacy_policy'];
    isLoading =false;
    update();
  }
}