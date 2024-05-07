import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/authentication/controller/user/email_verification_controller.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/components/components.dart';
import '../../../../core/images/images.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/validator/app_validator.dart';
import 'package:pinput/pinput.dart';

class EmailVerificationScreen extends GetView<EmailVerificationController> {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EmailVerificationController());
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<EmailVerificationController>(
          builder: (_) {
            return SingleChildScrollView(
              child: Container(
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
                      child: Form(
                        key: controller.formKey,
                        child: Directions(
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
                                  AppWord.emailVerification,
                                  style: TextStyle(
                                    fontSize: AppFonts.subTitleFont(context),
                                  ),
                                ).marginSymmetric(vertical:
                                    ScreenDimensions.heightPercentage(context, 3)),
                                Text(
                                  AppWord.weHaveSentTheCode,
                                  style: TextStyle(
                                    fontSize: AppFonts.subTitleFont(context),
                                  ),
                                ).marginOnly(
                                    bottom: ScreenDimensions.heightPercentage(context, 3)),
                                AppTextField(
                                  title: AppWord.email,

                                  controller: controller.emailController,
                                  validator: (value) {
                                    return AppValidator().emailValidator(
                                        value);
                                  },
                                  suffix: Icon(Icons.email,color: controller.emailController.text.isEmpty?CustomColors.black:CustomColors.gold,),
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  hintText: '___@gmail.com',
                                  keyboardType: TextInputType.emailAddress,
                                ).paddingSymmetric(
                                    horizontal: ScreenDimensions.widthPercentage(context, 5))
                                    .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                Pinput(
                                  keyboardType: TextInputType.number,
                                  length: 6,
                                  controller: controller.otpController,
                                  errorTextStyle: TextStyle(fontSize: AppFonts.smallTitleFont(context),color: CustomColors.red),
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  validator: (value){
                                    if(value.toString().isEmpty){
                                      ControllerSnackBar(errorMessage: AppWord.emptyOTP);
                                      return AppWord.emptyOTP;
                                    }if(value.toString().length!=6){
                                      ControllerSnackBar(errorMessage: AppWord.otpMustBe6);
                                      return AppWord.otpMustBe6;
                                    }
                                  },
                                ),
                                // OTPTextField(
                                //   length: 6,
                                //   width: ScreenDimensions.screenWidth(context),
                                //   fieldWidth: ScreenDimensions.widthPercentage(context, 12),
                                //   style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),
                                //   textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                //   keyboardType: TextInputType.number,
                                //   controller: controller.otpController,
                                //   fieldStyle: FieldStyle.box,
                                //   outlineBorderRadius: ScreenDimensions.radius(context, 1),
                                //   onCompleted: (pin) {
                                //     Get.log("Completed: $pin");
                                //   },
                                // ).paddingSymmetric(
                                //     horizontal:
                                //     ScreenDimensions.heightPercentage(context, 5)),
                                AppButton(
                                    text: Text(
                                      AppWord.createAccount,
                                      style: TextStyle(
                                        fontSize: AppFonts.smallTitleFont(context),
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      if(!(controller.formKey.currentState!.validate())){
                                        return ;
                                      }else{
                                        controller.verify();
                                      }
                                    },
                                    buttonBackground: AppImages.buttonLiteBackground)
                                    .marginOnly(
                                  top: ScreenDimensions.heightPercentage(context, 7.5),
                                  bottom: ScreenDimensions.heightPercentage(context, 5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Padding(
                      padding: EdgeInsets.all(ScreenDimensions.widthPercentage(context, 2)),
                      child: const Directions(child: BackArrow(color: Colors.white)),
                    )),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
