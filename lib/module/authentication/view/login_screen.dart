import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/validator/app_validator.dart';
import 'package:gold_shop/module/authentication/controller/user/user_login_controller.dart';
import '../../../core/components/components.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/utils/dimensions.dart';
import 'check_code_screen.dart';
import 'user/signup_screen.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    List<String>phoneNumber = [];
    return GetBuilder<LoginController>(
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
                    top: ScreenDimensions.heightPercentage(context, 13),
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
                          vertical:
                              ScreenDimensions.heightPercentage(context, 3)),
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
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: ScreenDimensions.screenWidth(context),
                            ),
                            Text(
                              AppWord.loginAsUser,
                              style: TextStyle(
                                fontSize: AppFonts.subTitleFont(context),
                              ),
                            ).marginSymmetric(vertical: ScreenDimensions.heightPercentage(context, 3)),
                            AppTextField(
                              controller: controller.phoneController,
                              validator: (value) {
                                phoneNumber = value.toString().characters.toList();
                                if(phoneNumber[0]!='0'||phoneNumber[1]!='5'){
                                  return AppWord.mustStartWith05;
                                }
                                return AppValidator().phoneValidator(value);
                              },
                              hintText: '05********',
                              title: AppWord.phoneNumber,
                              keyboardType: TextInputType.phone,
                              suffix: Icon(Icons.phone,color: controller.phoneController.text.isEmpty?CustomColors.black:CustomColors.gold,),
                              onChanged: (value){
                                controller.update();
                              },
                            ).paddingSymmetric(
                                horizontal: ScreenDimensions.widthPercentage(context, 5)),
                            AppTextField(
                              controller: controller.passwordController,
                              title: AppWord.password,
                              hintText: AppWord.atLeast9Characters,
                              maxLines: 1,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                return AppValidator().passwordValidator(value);
                              },
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
                            )
                                .paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5))
                                .marginSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                            Align(
                              alignment: Get.locale == const Locale('ar')
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(
                                    const CheckCodeScreen(),
                                    transition: Transition.rightToLeft,
                                  );
                                },
                                child: Text(
                                  AppWord.forgotPassword,
                                  style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.gold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: CustomColors.gold,
                                  ),
                                ).paddingSymmetric(
                                    horizontal:
                                        ScreenDimensions.widthPercentage(
                                            context, 5)),
                              ),
                            ),
                            AppButton(
                                text: Text(
                                  AppWord.login,
                                  style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.white,
                                  ),
                                ),
                                onTap: ()  {
                                  if (!(controller.formKey.currentState!.validate())) return;
                                  controller.loader
                                      ?Get.dialog(WillPopScope(
                                    onWillPop: ()async{
                                      return false;
                                    },
                                      child: Center(child: CircularProgressIndicator(color: CustomColors.gold,),)),barrierDismissible: false)
                                      :Get.snackbar(AppWord.note,AppWord.loggedOut);
                                  controller.update();
                                  controller.login();
                                  // Get.dialog(
                                  //   Material(
                                  //     color: Colors.transparent,
                                  //     child: BackdropFilter(
                                  //       filter: ImageFilter.blur(
                                  //           sigmaY: 10, sigmaX: 10),
                                  //       child: Container(
                                  //         height: ScreenDimensions.heightPercentage(
                                  //             context, 25),
                                  //         width: ScreenDimensions.widthPercentage(
                                  //             context, 50),
                                  //         margin: EdgeInsetsDirectional.symmetric(
                                  //             vertical: ScreenDimensions
                                  //                 .heightPercentage(
                                  //                 context, 30),
                                  //             horizontal: ScreenDimensions
                                  //                 .widthPercentage(
                                  //                 context, 5)),
                                  //         padding: EdgeInsetsDirectional.symmetric(
                                  //             horizontal: ScreenDimensions
                                  //                 .widthPercentage(
                                  //                 context, 5)),
                                  //         decoration: BoxDecoration(
                                  //             color: CustomColors.white,
                                  //             borderRadius:
                                  //             BorderRadius.circular(
                                  //                 ScreenDimensions
                                  //                     .widthPercentage(
                                  //                     context, 1))),
                                  //         child: Column(
                                  //           children: [
                                  //             Align(
                                  //                 alignment:
                                  //                 Alignment.centerLeft,
                                  //                 child: GestureDetector(
                                  //                     onTap: () {
                                  //                       Get.back();
                                  //                     },
                                  //                     child: SizedBox(
                                  //                       width: ScreenDimensions.widthPercentage(context, 2),
                                  //                       height: ScreenDimensions.heightPercentage(context, 1),
                                  //                       child: SvgPicture.asset(
                                  //                           AppImages.x,
                                  //                           width: ScreenDimensions.widthPercentage(
                                  //                               context,
                                  //                               3)),
                                  //                     ))).paddingSymmetric(
                                  //                 vertical: ScreenDimensions.heightPercentage(
                                  //                     context, 2)),
                                  //             Text(
                                  //               AppWord.signupMethod,
                                  //               style: TextStyle(
                                  //                 fontSize:
                                  //                 AppFonts.smallTitleFont(
                                  //                     context) +
                                  //                     2,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 color: CustomColors.black,
                                  //               ),
                                  //             ).paddingOnly(
                                  //                 bottom: ScreenDimensions.heightPercentage(
                                  //                     context, 7)),
                                  //             Row(
                                  //               mainAxisAlignment:
                                  //               MainAxisAlignment
                                  //                   .spaceEvenly,
                                  //               children: [
                                  //                 GestureDetector(
                                  //                   onTap: () {
                                  //                   },
                                  //                   child: Column(
                                  //                     children: [
                                  //                       SvgPicture.asset(
                                  //                         AppImages.profileIcon,
                                  //                       ),
                                  //                       Text(
                                  //                         AppWord.user,
                                  //                         style: TextStyle(
                                  //                             fontSize: AppFonts
                                  //                                 .smallTitleFont(
                                  //                                 context),
                                  //                             color:
                                  //                             CustomColors
                                  //                                 .black),
                                  //                       )
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //                 GestureDetector(
                                  //                   onTap: () {},
                                  //                   child: Column(
                                  //                     children: [
                                  //                       SvgPicture.asset(
                                  //                         AppImages.store,
                                  //                       ),
                                  //                       Text(
                                  //                         AppWord.mediatorShop,
                                  //                         style: TextStyle(
                                  //                             fontSize: AppFonts
                                  //                                 .smallTitleFont(
                                  //                                 context),
                                  //                             color:
                                  //                             CustomColors
                                  //                                 .black),
                                  //                       )
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ],
                                  //         ).paddingSymmetric(
                                  //             horizontal: ScreenDimensions
                                  //                 .widthPercentage(context, 2)),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // );
                                },
                                buttonBackground:
                                    AppImages.buttonLiteBackground),
                            GestureDetector(
                              onTap: () {
                                Get.to(const UserSignUpScreen(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 700),);
                                // Get.dialog(
                                //   Material(
                                //     color: Colors.transparent,
                                //     child: BackdropFilter(
                                //       filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                //       child: Container(
                                //         height: ScreenDimensions.heightPercentage(
                                //             context, 25),
                                //         width: ScreenDimensions.widthPercentage(
                                //             context, 50),
                                //         margin: EdgeInsetsDirectional.symmetric(vertical: ScreenDimensions.heightPercentage(context, 30),horizontal: ScreenDimensions.widthPercentage(context, 5)),
                                //         padding: EdgeInsetsDirectional.symmetric(horizontal: ScreenDimensions.widthPercentage(context, 5)),
                                //         decoration: BoxDecoration(color: CustomColors.white,borderRadius: BorderRadius.circular(ScreenDimensions.widthPercentage(context, 1))),
                                //         child: Column(
                                //           children: [
                                //             Align(alignment: Alignment.centerLeft,child: GestureDetector(onTap: (){Get.back();},child: Container(child: SvgPicture.asset(AppImages.x,width: ScreenDimensions.widthPercentage(context, 3)),))).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                //             Text(
                                //               AppWord.signupMethod,
                                //               style: TextStyle(
                                //                 fontSize: AppFonts.smallTitleFont(context)+2,
                                //                 fontWeight: FontWeight.bold,
                                //                 color: CustomColors.black,
                                //               ),
                                //             ).paddingOnly(bottom: ScreenDimensions.heightPercentage(context, 7)),
                                //             Row(
                                //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //               children: [
                                //                 GestureDetector(
                                //                   onTap: (){
                                //                     },
                                //                 child: Column(
                                //                   children: [
                                //                     SvgPicture.asset(AppImages.profileIcon,),
                                //                     Text(AppWord.user,style: TextStyle(fontSize: AppFonts.smallTitleFont(context),color: CustomColors.black),)
                                //                   ],
                                //                 ),
                                //               ),
                                //                 GestureDetector(
                                //                   onTap: (){
                                //                     Get.to(const MediatorSignupScreen(),
                                //                         transition: Transition.rightToLeft,
                                //                         duration: const Duration(milliseconds: 700),);},
                                //                 child: Column(
                                //                   children: [
                                //                     SvgPicture.asset(AppImages.store,),
                                //                     Text(AppWord.mediatorShop,style: TextStyle(fontSize: AppFonts.smallTitleFont(context),color: CustomColors.black),)
                                //                   ],
                                //                 ),
                                //               ),
                                //               ],
                                //             ),
                                //           ],
                                //         ).paddingSymmetric(
                                //             horizontal:
                                //                 ScreenDimensions.widthPercentage(
                                //                     context, 2)),
                                //       ),
                                //     ),
                                //   ),
                                // );
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppWord.doNotHaveAccount,
                                      style: TextStyle(
                                        fontSize:
                                            AppFonts.smallTitleFont(context),
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: AppWord.createUserAccount,
                                      style: TextStyle(
                                        fontSize:
                                            AppFonts.smallTitleFont(context),
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.gold,
                                        decoration: TextDecoration.underline,
                                        decorationColor: CustomColors.gold,
                                      ),
                                    ),
                                  ],
                                ),
                              ).marginSymmetric(
                                  vertical: ScreenDimensions.heightPercentage(
                                      context, 2)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(child: Directions(child: Align(alignment: Alignment.topLeft,child: BackArrow(color: CustomColors.white,),),)),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
