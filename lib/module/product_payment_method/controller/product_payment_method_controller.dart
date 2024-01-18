import 'package:get/get.dart';

class ProductPaymentMethodController extends GetxController {
  bool inPerson = true;
  bool withMediatorShop = false;

  bool mediatorShopBetween = true;
  bool mediatorShopFromPlatform = false;

  bool privacyCheck = false;

  void isChecked() {
    if (inPerson) {
      inPerson = false;
      withMediatorShop = true;
    } else {
      inPerson = true;
      withMediatorShop = false;
    }
    update();
  }

  void withMediatorChecked() {
    if (mediatorShopBetween) {
      mediatorShopBetween = false;
      mediatorShopFromPlatform = true;
    } else {
      mediatorShopBetween = true;
      mediatorShopFromPlatform = false;
    }
    update();
  }

  void privacyIsChecked() {
    privacyCheck ? privacyCheck = true : privacyCheck = false;
    update();
  }
}
