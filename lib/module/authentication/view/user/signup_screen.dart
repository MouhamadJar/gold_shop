import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/validtor/app_validator.dart';
import 'package:gold_shop/module/authentication/controller/user/user_signup_controller.dart';
import 'package:gold_shop/module/authentication/view/login_screen.dart';
import 'package:gold_shop/module/privacy/view/privacy_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/components/components.dart';
import '../../../../core/components/maps.dart';
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
              body: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
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
                            height: ScreenDimensions.heightPercentage(context, 70),
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
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: ScreenDimensions.screenWidth(context),
                                  ),
                                  Text(
                                    AppWord.createUserAccount,
                                    style: TextStyle(
                                      fontSize: AppFonts.subTitleFont(context),
                                    ),
                                  ).marginSymmetric(
                                      vertical: ScreenDimensions.heightPercentage(context, 3)),
                                  AppTextField(
                                    controller: controller.firstNameController,
                                    validator: (value) {
                                      return AppValidator().nameValidator(
                                          value,3);
                                    },
                                    title: AppWord.firstName,
                                    suffix: Icon(Icons.person,color: controller.firstNameController.text.isEmpty?CustomColors.black:CustomColors.gold,),
                                    onChanged: (value){
                                      controller.update();
                                    },
                                    keyboardType: TextInputType.name,
                                  ).paddingSymmetric(
                                      horizontal: ScreenDimensions.widthPercentage(context, 5))
                                      .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                  AppTextField(
                                    title: AppWord.lastName,
                                    controller: controller.lastNameController,
                                    validator: (value) {
                                      return AppValidator().nameValidator(
                                          value,3);
                                    },
                                    suffix: Icon(Icons.person,color: controller.lastNameController.text.isEmpty?CustomColors.black:CustomColors.gold,),
                                    onChanged: (value){
                                      controller.update();
                                    },
                                    keyboardType: TextInputType.name,
                                  ).paddingSymmetric(
                                      horizontal: ScreenDimensions.widthPercentage(context, 5))
                                      .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
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
                                  )   .paddingSymmetric(
                                      horizontal: ScreenDimensions.widthPercentage(context, 5))
                                      .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                  AppTextField(
                                    title: AppWord.phoneNumber,
                                    controller: controller.phoneController,
                                    validator: (value) {
                                      return AppValidator().phoneValidator(
                                          value);
                                    },
                                    keyboardType: TextInputType.phone,
                                    suffix: Icon(Icons.phone,color: controller.phoneController.text.isEmpty?CustomColors.black:CustomColors.gold,),
                                    onChanged: (value){
                                      controller.update();
                                    },
                                  ).paddingSymmetric(
                                      horizontal: ScreenDimensions.widthPercentage(context, 5))
                                      .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                  AppTextField(
                                    maxLines: 1,
                                    title: AppWord.password,
                                    controller: controller.passwordController,
                                    validator: (value) {
                                      return AppValidator().passwordValidator(
                                          value);
                                    },
                                    keyboardType: TextInputType.name,
                                    suffix: Icon(Icons.lock,color: controller.passwordController.text.isEmpty?CustomColors.black:CustomColors.gold,),
                                    onChanged: (value){
                                      controller.update();
                                    },
                                    obscureText: controller.hidePassword,
                                    prefix: GestureDetector(
                                        onTap: (){
                                          controller.hidePassword = !controller.hidePassword;
                                          controller.update();
                                        },
                                        child: Icon(Icons.remove_red_eye,color: controller.hidePassword?CustomColors.black:CustomColors.gold,)),
                                  ).paddingSymmetric(
                                      horizontal: ScreenDimensions.widthPercentage(context, 5))
                                      .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                  GetBuilder<UserSignupController>(
                                    builder: (_) {
                                      return AppGoogleMap(
                                        markers: controller.markers,
                                        onTap: controller.zoomed?controller.onGoogleMapTapped:(latLng){
                                          controller.update();
                                          Get.snackbar(AppWord.warning,AppWord.pleaseZoomIn);
                                        },
                                        onCameraMoved: (cameraPosition){
                                          if (cameraPosition.zoom>=19.0){
                                            controller.zoomed = true;
                                          }
                                          else{
                                            controller.zoomed = false;
                                          }
                                          controller.update() ;
                                        },
                                      ).paddingSymmetric(
                                          vertical: ScreenDimensions.heightPercentage(context, 2), horizontal:
                                          ScreenDimensions.widthPercentage(context, 5)
                                      );
                                    }
                                  ),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.area,
                                      subtitle: controller.country,
                                    ),
                                  ).marginOnly(bottom:
                                      ScreenDimensions.heightPercentage(context, 5)),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.state,
                                      subtitle: controller.state,
                                    ),
                                  ).marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(context, 5)),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.city,
                                      subtitle: controller.city,
                                    ),
                                  ).marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(context, 5)),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.neighborhood,
                                      subtitle: controller.neighborhood,
                                    ),
                                  ).marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(context, 5)),
                                  Directions(
                                    child: EditProfileCard(
                                      title: AppWord.street,
                                      subtitle: controller.street,
                                    ),
                                  ).marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(context, 5)),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: controller.check,
                                        onChanged: (value) {
                                          controller.check = value!;
                                          controller.update();
                                        },
                                        activeColor: CustomColors.gold,).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 1)),
                                      Text( AppWord.acceptTerms,
                                        style: TextStyle(
                                          fontSize: AppFonts
                                              .smallTitleFont(context),
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.black,
                                        ),),
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(const Privacy(),transition: Transition.fade,duration: const Duration(milliseconds: 700));
                                        },
                                        child: SizedBox(
                                          child: Text(' ${AppWord.terms}',
                                            style: TextStyle(
                                          fontSize: AppFonts.smallTitleFont(context),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                                                                  ),),
                                        ),
                                      ),
                                    ],
                                  ).marginOnly(
                                      bottom: ScreenDimensions.heightPercentage(context, 5)),
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
                                      onTap: controller.check?() {
                                        if (!(controller.formKey.currentState!.validate())) {
                                          Get.snackbar(AppWord.warning, AppWord.checkAllRequiredFields);
                                          return;
                                        }
                                        Get.dialog(
                                            WillPopScope(child: Center(child: CircularProgressIndicator(color: CustomColors.gold,),), onWillPop: ()async{return false;})
                                            ,barrierDismissible: false);
                                        controller.signup();
                                      }:(){},
                                      buttonBackground: controller.check?AppImages.buttonLiteBackground:AppImages.buttonDarkBackground),
                                  GestureDetector(
                                    onTap: () {
                                      Get.off(const LoginScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 700));
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
                                            text: AppWord.loginAsUser,
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
                        Positioned(child: Directions(child: Align(
                            alignment: Alignment.topLeft,
                            child: BackArrow(color: CustomColors.white,)),))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
