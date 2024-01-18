import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/privacy/controller/privacy_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';

class Privacy extends GetView<PrivacyController> {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PrivacyController());
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.white,
        centerTitle: true,
        title: Text(
          AppWord.privacyPolicy,
          style: TextStyle(
              color: CustomColors.black,
              fontSize: AppFonts.subTitleFont(context),
              fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: CustomColors.black,
          ),
        ),
      ),
      body: GetBuilder<PrivacyController>(initState: (state){
        controller.privacy();
      },
        builder: (_) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.gold,
                  ),
                )
              : Text(
                  controller.privacyText!,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: AppFonts.smallTitleFont(context),
                    fontWeight: FontWeight.bold,
                  ),
                ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 3),horizontal: ScreenDimensions.widthPercentage(context, 3));
        }
      ),
    );
  }
}
