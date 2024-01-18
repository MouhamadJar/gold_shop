import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/about_us/controller/about_us_controller.dart';

import '../../../core/colors/colors.dart';

class AboutUs extends GetView<AboutUsController> {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AboutUsController());
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.white,
        centerTitle: true,
        title: Text(
          AppWord.info,
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
      body: GetBuilder<AboutUsController>(initState: (state) {
        controller.aboutUs();
      }, builder: (_) {
        return controller.isLoading?Center(child: CircularProgressIndicator(color: CustomColors.gold,),):Text(
          controller.aboutUsText!,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppFonts.smallTitleFont(context),
          ),
        ).paddingSymmetric(
          vertical: ScreenDimensions.heightPercentage(context, 3),
          horizontal: ScreenDimensions.widthPercentage(context, 3),
        );
      }),
    );
  }
}
