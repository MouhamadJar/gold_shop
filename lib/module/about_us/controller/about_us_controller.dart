import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';

class AboutUsController extends GetxController {
  bool isLoading = true;
  String? aboutUsText;

  void aboutUs() async {
    Map<String, dynamic> data = await DioHelper.aboutUs();
    aboutUsText = data['data']['about_us'];
    isLoading = false;
    update();
  }
}
