
import 'dart:io';

import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/invoice/model/invoice_model.dart';

import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/image_handler.dart';
import '../../main/user/view/main_screen_view.dart';

class InvoiceController extends GetxController{
  bool isChecked = false;
  bool isLoading = true;
  bool paymentInfoLoading = true;
  bool bankInfoLoading = true;
  String buttonBackground = AppImages.buttonDarkBackground;
  PaymentInfoModel? paymentInfoModel;
  BankInfoModel? bankInfoModel;
  InvoiceModel? invoiceModel;
  dynamic commission;
  File? image;

  void checked (){
    if(isChecked){
      buttonBackground =AppImages.buttonDarkBackground;
      isChecked = !isChecked;
    }else{
      buttonBackground =AppImages.buttonLiteBackground;
      isChecked = !isChecked ;
    }
    update();
  }

  void getPaymentInfo()async{
    Map<String,dynamic> data = await DioHelper.paymentInfo();
    paymentInfoModel = PaymentInfoModel.fromJson(json: data['data']);
    paymentInfoLoading = false;
    update();
  }

  void getBankInfo()async{
    Map<String,dynamic> data = await DioHelper.bankInfo();
    bankInfoModel = BankInfoModel.fromJson(json: data['data']);
    bankInfoLoading = false;
    update();
  }

  void getInvoiceData ({required int orderId})async{
    Map<String,dynamic> data = await DioHelper.invoice(orderId: orderId);
   invoiceModel = InvoiceModel.fromJson(json: data['data']);
   getAppCommission();
   isLoading= false;
   update();
  }

  void getAppCommission()async{
    Map<String,dynamic> data = await DioHelper.appCommission();
    commission = data['data']['commission'];
    update();
  }

  void pickImage() async {
    ImageHandler.pickImage().then((value) {
      if (value != null) {
        image = File(value);
        update();
        Get.snackbar(AppWord.done, '');
        return;
      }
      Get.snackbar(AppWord.warning, AppWord.doNotPickImage);
      return;
    });
  }
  void uploadNotificationImage({required int orderId})async{
    await DioHelper.notificationImage(orderId: invoiceModel!.id, image: image!.path).then((value) {
      if (value['errors'] != null) {
        Get.snackbar(AppWord.warning, value['message']);
        return;
      } else {
        Get.offAll(const MainScreen());
        Get.snackbar(AppWord.done, AppWord.editProfile);
        return;
      }
    });
  }
}