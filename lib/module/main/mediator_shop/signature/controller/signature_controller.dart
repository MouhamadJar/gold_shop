import 'dart:io';

import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/image_handler.dart';

class SignatureController extends GetxController {
  File? signatureImage;
  bool isLoading = false;

  void pickSignatureImage() async {
    await ImageHandler.pickImage().then((value) {
      if (value != null) {
        signatureImage = File(value);
      } else {
        Get.snackbar(AppWord.warning, AppWord.doNotPickImage);
      }
      update();
    });
  }

  void uploadSignatureImage() async {
    isLoading = true;
    update();
    await DioHelper.uploadSignature(signatureImage: signatureImage!)
        .then((value) {
      isLoading = false;
      update();
      if (value['errors'] == null) {
        Get.snackbar(AppWord.warning, AppWord.checkInternet);
      } else {
        Get.snackbar(AppWord.done, '');
      }
    });
  }
}
