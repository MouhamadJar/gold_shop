import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/components/components.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/utils/dimensions.dart';
import 'check_code_screen.dart';
import 'user/signup_screen.dart';

class ResetPasswordScreen  extends StatelessWidget {
  const ResetPasswordScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: ScreenDimensions.screenHeight(context),
            width: ScreenDimensions.screenWidth(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  stops: const [0, 0.5],
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    CustomColors.grey1,
                    CustomColors.black
                  ]),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -ScreenDimensions.heightPercentage(context, 80),
                  left: -ScreenDimensions.widthPercentage(context, 55),
                  right: -ScreenDimensions.widthPercentage(context, 50),
                  bottom: -ScreenDimensions.heightPercentage(context, 60),
                  child: SvgPicture.asset(
                    AppImages.splashScreen,
                    //fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  top: ScreenDimensions.heightPercentage(context, 5),
                  child: DelayedDisplay(
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
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: ScreenDimensions.screenWidth(context),
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 3)),
                    decoration: BoxDecoration(
                      color: CustomColors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          ScreenDimensions.radius(context, 5),
                        ),
                        topLeft: Radius.circular(
                          ScreenDimensions.radius(context, 5),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: ScreenDimensions.screenWidth(context),
                        ),
                        Text(
                          AppWord.resetPassword,
                          style: TextStyle(
                            fontSize: AppFonts.subTitleFont(context),
                          ),
                        ).marginSymmetric(
                            vertical:
                            ScreenDimensions.heightPercentage(context, 3)),
                        AppTextField(
                          title: AppWord.newPassword,
                          keyboardType: TextInputType.phone,
                        ).paddingSymmetric(
                            horizontal:
                            ScreenDimensions.widthPercentage(context, 5)),
                        AppTextField(
                          title: AppWord.confirmNewPassword,
                          keyboardType: TextInputType.phone,
                        )
                            .paddingSymmetric(
                            horizontal:
                            ScreenDimensions.widthPercentage(context, 5))
                            .marginSymmetric(
                            vertical: ScreenDimensions.heightPercentage(
                                context, 2)),
                        AppButton(
                            text: Text(
                              AppWord.reset,
                              style: TextStyle(
                                fontSize: AppFonts.smallTitleFont(context),
                                fontWeight: FontWeight.bold,
                                color: CustomColors.white,
                              ),
                            ),
                            onTap: () {},
                            buttonBackground: AppImages.buttonLiteBackground) .marginOnly(
                          top: ScreenDimensions.heightPercentage(context, 6),
                          bottom: ScreenDimensions.heightPercentage(context, 3),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
