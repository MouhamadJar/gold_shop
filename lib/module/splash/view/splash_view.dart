import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import '../controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return GetBuilder<SplashScreenController>(builder: (_) {
      return SafeArea(
        child: Scaffold(
          body: Container(
            height: ScreenDimensions.screenHeight(context),
            width: ScreenDimensions.screenWidth(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  stops: const [0, 0.5],
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    //CustomColors().grey,
                    CustomColors.grey1,
                    CustomColors.black
                  ]),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -ScreenDimensions.heightPercentage(context, 35),
                  left: -ScreenDimensions.widthPercentage(context, 45),
                  right: -ScreenDimensions.widthPercentage(context, 50),
                  bottom: -ScreenDimensions.heightPercentage(context, 60),
                  child: SvgPicture.asset(
                    AppImages.splashScreen,
                    //fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: ScreenDimensions.heightPercentage(context, 27),
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      DelayedDisplay(
                        slidingBeginOffset: const Offset(0, 10),
                        delay: const Duration(milliseconds: 150),
                        child: CircleAvatar(
                          radius: ScreenDimensions.widthPercentage(context, 18),
                          backgroundColor: CustomColors.white,
                          child: Text(
                            'LOGO',
                            style: TextStyle(
                                color: CustomColors.gold,
                                fontSize: AppFonts.titleFont(context),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenDimensions.heightPercentage(context, 5),),
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 750),
                        slidingBeginOffset: const Offset(0,10),
                        child: Text(
                          AppWord.splashText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: AppFonts.subTitleFont(context),
                              color: CustomColors.white),
                        ),
                      ),
                    ],
                  ),
                ), //Logo//title
              ],
            ),
          ),
        ),
      );
    });
  }
}
