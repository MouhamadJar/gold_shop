import 'dart:io';

import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/image_handler.dart';

import '../../product_code/view/product_code_view.dart';

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
    await DioHelper.uploadSignature(signatureImage: signatureImage!).then((value) {
      isLoading = false;
      update();
      if (value['success']) {
        Get.snackbar(AppWord.done, '');
        StorageHandler().setSignature(true);
        Get.off(() => const ProductCode());
      } else  {
        if(value['message']=='You already have a Signature.') {
          StorageHandler().setSignature(true);
          Get.off(() => const ProductCode());
          return;
        }
        Get.snackbar(AppWord.warning, AppWord.checkInternet);
      }
    });
  }

  void checkSignature()async{
    await DioHelper.checkSignature().then((value) {
    if(value['data']['signature'] == 1){
      Get.offAll(() => const ProductCode(),transition:  Transition.fade,duration:  const Duration(milliseconds:  700));
      update();
      return;
    }else if(value['data']['signature'] == 0 ){
      uploadSignatureImage();
      Get.off(() => const ProductCode(),transition:  Transition.fade, duration:  const Duration(milliseconds: 700));
      update();
      return;
    }
  });
  update();
  }
  @override
  void onInit() {
    checkSignature();
    super.onInit();
  }
}
