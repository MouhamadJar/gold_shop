import 'package:get/get.dart';
import '../../main/user/view/main_screen_view.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAll(const MainScreen(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 800));
    });

    super.onInit();
  }
}
