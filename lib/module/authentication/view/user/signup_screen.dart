import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/validator/app_validator.dart';
import 'package:gold_shop/module/authentication/controller/user/user_signup_controller.dart';
import 'package:gold_shop/module/authentication/view/login_screen.dart';
import 'package:gold_shop/module/privacy/view/privacy_view.dart';
import '../../../../core/components/components.dart';
import '../../../../core/components/maps.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/images/images.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../edit_profile/components/edit_profile_components.dart';

class UserSignUpScreen extends GetView<UserSignupController> {
  const UserSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserSignupController());
    List<String>phoneNumber = [];
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
                                    hintText: AppWord.atLeast6Characters,
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
                                    hintText: AppWord.atLeast6Characters,
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
                                    hintText: '05********',
                                    validator: (value) {
                                      phoneNumber = value.toString().characters.toList();
                                      if(value==null||value.toString().isEmpty){
                                        return AppValidator().phoneValidator(value);
                                      }
                                      if(phoneNumber[0]!='0'||phoneNumber[1]!='5'){
                                        return AppWord.mustStartWith05;
                                      }
                                      else {
                                        return AppValidator().phoneValidator(
                                            value);
                                      }
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
                                    hintText: AppWord.atLeast9Characters,
                                    controller: controller.passwordController,
                                    validator: (value) {
                                      return AppValidator().passwordValidator(value);
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
                                  AppTextField(
                                    controller: controller.descriptionController,
                                    title: AppWord.mediatorDescription,
                                    hintText: AppWord.atLeast9Characters,
                                    suffix:  Icon(Icons.description,color: controller.descriptionController.text.isEmpty?Colors.black:CustomColors.gold,),
                                    onChanged: (value){
                                      controller.update();
                                    },
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value== null || value.toString().isEmpty){
                                        ControllerSnackBar(errorMessage: AppWord.emptyDescription);
                                        return AppWord.emptyDescription;
                                      }
                                      if(value.toString().isNum){
                                        ControllerSnackBar(errorMessage: AppWord.descriptionShouldNotBeOnlyNumbers);
                                        return AppWord.descriptionShouldNotBeOnlyNumbers;
                                      }
                                      if(value.toString().length < 9){
                                        ControllerSnackBar(errorMessage: AppWord.descriptionMustBeAtLeast9);
                                        return AppWord.descriptionMustBeAtLeast9;
                                      }
                                      return null;
                                    },
                                  )
                                      .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                      .marginOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                                  // GetBuilder<UserSignupController>(
                                  //   builder: (_) {
                                  //     return AppGoogleMap(
                                  //       markers: controller.markers,
                                  //       onTap: controller.zoomed?controller.onGoogleMapTapped:(latLng){
                                  //         controller.update();
                                  //         Get.snackbar(AppWord.warning,AppWord.pleaseZoomIn);
                                  //       },
                                  //       onCameraMoved: (cameraPosition){
                                  //         if (cameraPosition.zoom==19.0){
                                  //           controller.zoomed = true;
                                  //           controller.update();
                                  //         }if(cameraPosition.zoom ==18.9){
                                  //           controller.zoomed = false;
                                  //           controller.update();
                                  //         }
                                  //       },
                                  //     ).paddingSymmetric(
                                  //         vertical: ScreenDimensions.heightPercentage(context, 2), horizontal:
                                  //         ScreenDimensions.widthPercentage(context, 5)
                                  //     );
                                  //   }
                                  // ),
                                  // Directions(
                                  //   child: EditProfileCard(
                                  //     title: AppWord.area,
                                  //     subtitle: controller.country,
                                  //   ),
                                  // ).marginOnly(bottom:
                                  //     ScreenDimensions.heightPercentage(context, 5)),
                                  // Directions(
                                  //   child: EditProfileCard(
                                  //     title: AppWord.state,
                                  //     subtitle: controller.state,
                                  //   ),
                                  // ).marginOnly(
                                  //     bottom: ScreenDimensions.heightPercentage(context, 5)),
                                  // Directions(
                                  //   child: EditProfileCard(
                                  //     title: AppWord.city,
                                  //     subtitle: controller.city,
                                  //   ),
                                  // ).marginOnly(
                                  //     bottom: ScreenDimensions.heightPercentage(context, 5)),
                                  // Directions(
                                  //   child: EditProfileCard(
                                  //     title: AppWord.neighborhood,
                                  //     subtitle: controller.neighborhood,
                                  //   ),
                                  // ).marginOnly(
                                  //     bottom: ScreenDimensions.heightPercentage(context, 5)),
                                  // Directions(
                                  //   child: EditProfileCard(
                                  //     title: AppWord.street,
                                  //     subtitle: controller.street,
                                  //   ),
                                  // ).marginOnly(
                                  //     bottom: ScreenDimensions.heightPercentage(context, 5)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AppPopUpMenu(
                                        title: controller.selectedCountry,
                                        items: controller.countries.map((e) => PopupMenuItem(
                                          value: e,
                                          onTap: (){
                                            controller.selectedCountry=e;
                                            controller.getCities(country: e);
                                            controller.update();
                                          },
                                          child: Text(
                                            e,
                                            style: TextStyle(fontSize: AppFonts.smallTitleFont(context),
                                            ),
                                          ),),).toList(),),
                                      AppPopUpMenu(
                                        title: controller.selectedCity,
                                        items: controller.cities.map((e) => PopupMenuItem(
                                          value: e.city,
                                          onTap: (){
                                            controller.selectedCity=e.city;
                                            controller.addressId = e.addressId;
                                            controller.update();
                                          },
                                          child: Text(
                                            e.city,
                                            style: TextStyle(fontSize: AppFonts.smallTitleFont(context),
                                            ),
                                          ),),).toList(),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: controller.check,
                                        onChanged: (value) {
                                          controller.check = value!;
                                          controller.update();
                                        },
                                        fillColor: controller.check?MaterialStatePropertyAll(CustomColors.gold):MaterialStatePropertyAll(CustomColors.silver),
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
