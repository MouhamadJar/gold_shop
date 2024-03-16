import 'package:get/get.dart';
import 'package:gold_shop/module/main/mediator_shop/product_code/view/product_code_view.dart';
import 'package:gold_shop/module/main/mediator_shop/signature/view/mediator_shop_view.dart';
import '../../../core/storage_handler/storage_handler.dart';
import '../../main/user/view/main_screen_view.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      if (StorageHandler().role == 'user' || StorageHandler().role == 'not authenticated'||StorageHandler().hasToken==false) {
        Get.offAll(
            const MainScreen(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 800));
      }else if(StorageHandler().role == 'shop') {
        if (StorageHandler().hasSignature == true){
        Get.offAll(
            const ProductCode(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 800));
        }else {
          Get.offAll(
              const MediatorShopHome(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 800));
        }
      }
    });

    super.onInit();
  }
}
