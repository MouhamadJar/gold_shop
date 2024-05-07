
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/buy_order/view/buy_order_view.dart';
import 'package:gold_shop/module/category_products/controller/category_products_controller.dart';
import 'package:gold_shop/module/invoice/model/invoice_model.dart';
import 'package:gold_shop/module/invoice/view/invoice_view.dart';

import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/image_handler.dart';
import '../../main/user/view/main_screen_view.dart';
import '../../put_aside_purchase/controller/put_aside_purchase_controller.dart';
import '../../put_aside_purchase/view/put_side_purcahse_view.dart';

class InvoiceController extends GetxController{
  bool isChecked = false;
  bool isLoading = true;
  bool paymentInfoLoading = true;
  bool appCommissionLoading = true;
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
    isLoading = true;
    update();
    getAppCommission();
    Map<String,dynamic> data = await DioHelper.invoice(orderId: orderId);
   invoiceModel = InvoiceModel.fromJson(json: data['data']);
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
        ControllerSnackBar(errorMessage: AppWord.done);
        return;
      }
      ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.doNotPickImage);
      return;
    });
  }

  void uploadNotificationImage({required int orderId})async{
    if (image != null ){
    await DioHelper.notificationImage(orderId: invoiceModel!.id, image: image!.path).then((value) {
      if (value['errors'] != null) {
        ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: value['message']);
        return;
      } else {
        Get.back();
        update();
        ControllerSnackBar(errorTitle: AppWord.done,errorMessage: AppWord.notificationUploadedSuccessfully);
        Get.defaultDialog(barrierDismissible: true,
          title: '',
          content: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: Get.width*0.8,
              height: Get.height*0.3,
              decoration: BoxDecoration(
                  color: CustomColors.gold,
                  borderRadius: BorderRadius.circular(Get.height*0.01)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    size: Get.width*0.1,
                    Icons.verified,
                    color: CustomColors.white,
                  ),
                  Text(
                    AppWord.payingProcessDone,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: Get.height*0.025, color: CustomColors.black),
                  )
                ],
              ),
            ),
          ),);
        Future.delayed(const Duration(milliseconds: 2000),() => Get.offAll(const MainScreen(),transition: Transition.fade,duration: const Duration(milliseconds: 700)));
        return;
      }
    });
    update();
    }else{
      Get.back();
      ControllerSnackBar(errorTitle: AppWord.warning,errorMessage: AppWord.uploadNotificationPicture);
      update();
    }
    update();
  }
}