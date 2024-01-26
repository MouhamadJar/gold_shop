import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/validtor/app_validator.dart';
import 'package:gold_shop/module/authentication/controller/user/user_signup_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/components/components.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/images/images.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../edit_profile/components/edit_profile_components.dart';
import 'verify_account_screen.dart';

class UserSignUpScreen extends GetView<UserSignupController> {
  const UserSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserSignupController());
    return GetBuilder<UserSignupController>(
        builder: (_) {
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
                            radius: ScreenDimensions.widthPercentage(
                                context, 18),
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
                          height: ScreenDimensions.heightPercentage(
                              context, 70),
                          width: ScreenDimensions.screenWidth(context),
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenDimensions.heightPercentage(
                                  context, 3)),
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
                          child: SingleChildScrollView(

                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: ScreenDimensions.screenWidth(
                                        context),
                                  ),
                                  Text(
                                    AppWord.createAccount,
                                    style: TextStyle(
                                      fontSize: AppFonts.subTitleFont(context),
                                    ),
                                  ).marginSymmetric(
                                      vertical:
                                      ScreenDimensions.heightPercentage(
                                          context, 3)),
                                  AppTextField(
                                    controller: controller.firstNameController,
                                    validator: (value) {
                                      return AppValidator().nameValidator(
                                          value);
                                    },
                                    title: AppWord.firstName,
                                    keyboardType: TextInputType.name,
                                  )
                                      .paddingSymmetric(
                                      horizontal: ScreenDimensions
                                          .widthPercentage(
                                          context, 5))
                                      .marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(
                                          context, 2)),
                                  AppTextField(
                                    title: AppWord.lastName,
                                    controller: controller.lastNameController,
                                    validator: (value) {
                                      return AppValidator().nameValidator(
                                          value);
                                    },
                                    keyboardType: TextInputType.name,
                                  )
                                      .paddingSymmetric(
                                      horizontal: ScreenDimensions
                                          .widthPercentage(
                                          context, 5))
                                      .marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(
                                          context, 2)),
                                  AppTextField(
                                    title: AppWord.email,
                                    controller: controller.emailController,
                                    validator: (value) {
                                      return AppValidator().emailValidator(
                                          value);
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                  )   .paddingSymmetric(
                                      horizontal: ScreenDimensions
                                          .widthPercentage(
                                          context, 5))
                                      .marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(
                                          context, 2)),
                                  AppTextField(
                                    title: AppWord.userName,
                                    controller: controller.userNameController,
                                    validator: (value) {
                                      return AppValidator().userNameValidator(
                                          value);
                                    },
                                    keyboardType: TextInputType.name,
                                  )
                                      .paddingSymmetric(
                                      horizontal: ScreenDimensions
                                          .widthPercentage(
                                          context, 5))
                                      .marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(
                                          context, 2)),
                                  AppTextField(
                                    title: AppWord.phoneNumber,
                                    controller: controller.phoneController,
                                    validator: (value) {
                                      return AppValidator().phoneValidator(
                                          value);
                                    },
                                    keyboardType: TextInputType.phone,
                                    suffix: const Icon(Icons.call),
                                  )
                                      .paddingSymmetric(
                                      horizontal: ScreenDimensions
                                          .widthPercentage(
                                          context, 5))
                                      .marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(
                                          context, 2)),
                                  AppTextField(
                                    title: AppWord.password,
                                    controller: controller.passwordController,
                                    validator: (value) {
                                      return AppValidator().passwordValidator(
                                          value);
                                    },
                                    keyboardType: TextInputType.name,
                                    suffix: const Icon(Icons.lock),
                                  )
                                      .paddingSymmetric(
                                      horizontal: ScreenDimensions
                                          .widthPercentage(
                                          context, 5))
                                      .marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(
                                          context, 2)),
                                  GetBuilder<UserSignupController>(
                                    builder: (_) {
                                      return Container(
                                        width: ScreenDimensions.screenWidth(context),
                                        height: ScreenDimensions.heightPercentage(
                                            context, 25),
                                        decoration: BoxDecoration(border: Border.all()),
                                        child: GoogleMap(
                                          gestureRecognizers: {
                                            Factory(
                                                  () => EagerGestureRecognizer(
                                                  allowedButtonsFilter: (buttons) => true,
                                                  supportedDevices: {
                                                    PointerDeviceKind.touch
                                                  }),
                                            ),
                                          },
                                          initialCameraPosition: controller.position,
                                          onTap: controller.onGoogleMapTapped,
                                          markers: controller.markers,
                                        ),
                                      ).paddingSymmetric(
                                          vertical: ScreenDimensions.heightPercentage(
                                              context, 2),
                                          horizontal:
                                          ScreenDimensions.widthPercentage(
                                              context, 5)
                                      );
                                    }
                                  ),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.area,
                                      subtitle: AppWord.area,
                                    ),
                                  ).marginOnly(
                                      bottom:
                                      ScreenDimensions.heightPercentage(
                                          context, 5)),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.state,
                                      subtitle: AppWord.state,
                                    ),
                                  ).marginOnly(
                                      bottom:
                                      ScreenDimensions.heightPercentage(
                                          context, 5)),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.city,
                                      subtitle: AppWord.city,
                                    ),
                                  ).marginOnly(
                                      bottom:
                                      ScreenDimensions.heightPercentage(
                                          context, 5)),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.neighborhood,
                                      subtitle: AppWord.neighborhood,
                                    ),
                                  ).marginOnly(
                                      bottom:
                                      ScreenDimensions.heightPercentage(
                                          context, 5)),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.street,
                                      subtitle: AppWord.street,
                                    ),
                                  ).marginOnly(
                                      bottom:
                                      ScreenDimensions.heightPercentage(
                                          context, 5)),
                                  Row(
                                    children: [
                                      Checkbox(value: true,
                                        onChanged: (_) {},
                                        activeColor: CustomColors.gold,),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: AppWord.acceptTerms,
                                              style: TextStyle(
                                                fontSize: AppFonts
                                                    .smallTitleFont(context),
                                                fontWeight: FontWeight.bold,
                                                color: CustomColors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' ${AppWord.terms}',
                                              style: TextStyle(
                                                fontSize: AppFonts
                                                    .smallTitleFont(context),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ).marginOnly(
                                      bottom:
                                      ScreenDimensions.heightPercentage(
                                          context, 5)),
                                  AppButton(
                                      text: Text(
                                        AppWord.createAccount,
                                        style: TextStyle(
                                          fontSize: AppFonts.smallTitleFont(
                                              context),
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        if (!(controller.formKey.currentState!
                                            .validate())) {
                                          return;
                                        }
                                        controller.signup();
                                      },
                                      buttonBackground: AppImages
                                          .buttonLiteBackground),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppWord.alreadyHaveAccount,
                                            style: TextStyle(
                                              fontSize: AppFonts.smallTitleFont(
                                                  context),
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: AppWord.login,
                                            style: TextStyle(
                                              fontSize: AppFonts.smallTitleFont(
                                                  context),
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.gold,
                                              decoration: TextDecoration
                                                  .underline,
                                              decorationColor: CustomColors
                                                  .gold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).marginSymmetric(
                                        vertical:
                                        ScreenDimensions.heightPercentage(
                                            context, 2)),
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}
