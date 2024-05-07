// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/components/maps.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/edit_profile/view/edit_profile_view.dart';
import 'package:gold_shop/module/my_ads/view/my_ads_view.dart';
import 'package:gold_shop/module/profile/controller/profile_controller.dart';
import 'package:gold_shop/module/purchased_product/view/purchased_product_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/network/dio_helper.dart';
import '../../my_purchases_home/view/my_purchases_home_view.dart';
import '../../my_sells_home/view/my_sells_home_view.dart';
import '../components/profile_components.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: GetBuilder<ProfileController>(initState: (state) {
          controller.getProfile();
        }, builder: (_) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.gold,
                  ),
                )
              : SizedBox(
                  width: ScreenDimensions.screenWidth(context),
                  height: ScreenDimensions.screenHeight(context),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        SizedBox(
                          width: ScreenDimensions.screenWidth(context),
                          height: ScreenDimensions.heightPercentage(context, 60),
                          child: Stack(
                            children: [
                              Positioned(
                                top: ScreenDimensions.heightPercentage(
                                    context, 20),
                                left: -ScreenDimensions.widthPercentage(
                                    context, 30),
                                right: -ScreenDimensions.widthPercentage(
                                    context, 30),
                                child: Transform.rotate(
                                  angle: -120,
                                  child: Container(
                                    width: ScreenDimensions.screenWidth(context),
                                    height: ScreenDimensions.heightPercentage(context, 20),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(stops: const [0.1,0.5],
                                        colors: [
                                          CustomColors.gold,
                                          CustomColors.black,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: ScreenDimensions.heightPercentage(
                                      context, 6),
                                  child: CircleAvatar(
                                    backgroundColor: CustomColors.white,
                                    radius:
                                        ScreenDimensions.radius(context, 10),
                                  )),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: ScreenDimensions.heightPercentage(
                                      context, 7),
                                  child: CircleAvatar(
                                    backgroundColor: CustomColors.white1,
                                    radius: ScreenDimensions.radius(context, 9),
                                    child: controller.user!.photo != null
                                        ? GestureDetector(
                                            onTap: () {
                                              Get.dialog(BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 10, sigmaX: 10),
                                                child: InteractiveViewer(
                                                  child: AppNetworkImage(
                                                    baseUrlImages + controller.user!.photo!,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ));
                                            },
                                            child: AppNetworkImage(
                                              baseUrlImages + controller.user!.photo!,
                                              shape: BoxShape.circle,
                                              fit: BoxFit.contain,
                                              width: ScreenDimensions.widthPercentage(context, 40),
                                              height: ScreenDimensions.heightPercentage(context, 30),
                                            ),
                                          )
                                        : DelayedDisplay(
                                            child: Icon(
                                              Icons.person_2_outlined,
                                              size: ScreenDimensions
                                                  .heightPercentage(
                                                      context, 10),
                                            ),
                                          ),
                                  )),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: ScreenDimensions.heightPercentage(
                                    context, 26),
                                child: Column(
                                  children: [
                                    DelayedDisplay(
                                      delay: const Duration(milliseconds: 300),
                                      slidingBeginOffset: const Offset(5, 0),
                                      child: Text(
                                        '${controller.user!.firstName} ${controller.user!.lastName}',
                                        style: TextStyle(
                                          color: CustomColors.white,
                                          fontSize:
                                              AppFonts.subTitleFont(context),
                                        ),
                                      ),
                                    ),
                                    // DelayedDisplay(
                                    //   delay: const Duration(milliseconds: 600),
                                    //   slidingBeginOffset: const Offset(-5, 0),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: [
                                    //       Text(
                                    //         controller.user!.isVerified == 0
                                    //             ? AppWord.notActivatedAccount
                                    //             : AppWord.activatedAccount,
                                    //         style: TextStyle(
                                    //           color: CustomColors.white,
                                    //           fontSize: AppFonts.subTitleFont(
                                    //               context),
                                    //         ),
                                    //       ).paddingSymmetric(
                                    //           horizontal: ScreenDimensions
                                    //               .widthPercentage(context, 3)),
                                    //       controller.user!.isVerified == 0
                                    //           ? const SizedBox.shrink()
                                    //           : Icon(Icons.verified,
                                    //               color: CustomColors.white,
                                    //               size: ScreenDimensions
                                    //                   .widthPercentage(
                                    //                       context, 6)),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 1,
                                top: ScreenDimensions.heightPercentage(
                                    context, 50),
                                child: Column(
                                  children: [
                                    DelayedDisplay(
                                      delay: const Duration(milliseconds: 300),
                                      slidingBeginOffset: const Offset(5, 0),
                                      child:
                                      Directions(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              controller.user!.phoneNumber,
                                              style: TextStyle(
                                                  fontSize: AppFonts.smallTitleFont(context),
                                                  fontWeight: FontWeight.bold),
                                            ).paddingSymmetric(
                                                horizontal: ScreenDimensions.widthPercentage(context, 2)),
                                            SvgPicture.asset(AppImages.phone)
                                          ],
                                        ),
                                      ).paddingSymmetric(
                                          horizontal: ScreenDimensions.widthPercentage(context, 5),
                                          vertical: ScreenDimensions.heightPercentage(context, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 1,
                                top: ScreenDimensions.heightPercentage(
                                    context, 55),
                                child: Column(
                                  children: [
                                    DelayedDisplay(
                                      delay: const Duration(milliseconds: 300),
                                      slidingBeginOffset: const Offset(5, 0),
                                      child:
                                      Directions(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              controller.user!.email,
                                              style: TextStyle(
                                                  fontSize: AppFonts.smallTitleFont(context),
                                                  fontWeight: FontWeight.bold),
                                            ).paddingSymmetric(
                                                horizontal: ScreenDimensions.widthPercentage(
                                                    context, 2)),
                                            SvgPicture.asset(AppImages.email)
                                          ],
                                        ),
                                      ).paddingSymmetric(
                                          horizontal: ScreenDimensions.widthPercentage(context, 5),
                                          vertical: ScreenDimensions.heightPercentage(context, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              // Positioned(
                              //   right: 1,
                              //   top: ScreenDimensions.heightPercentage(
                              //       context, 50),
                              //   child: Column(
                              //     children: [
                              //       DelayedDisplay(
                              //         delay: const Duration(milliseconds: 300),
                              //         slidingBeginOffset: const Offset(5, 0),
                              //         child:
                              //         Directions(
                              //           child: Row(
                              //             mainAxisAlignment: MainAxisAlignment.end,
                              //             children: [
                              //               Text(
                              //                 'رقم الحساب البنكي',
                              //                 style: TextStyle(
                              //                     fontSize: AppFonts.smallTitleFont(context),
                              //                     fontWeight: FontWeight.bold),
                              //               ).paddingSymmetric(
                              //                   horizontal: ScreenDimensions.widthPercentage(context, 2)),
                              //             ],
                              //           ),
                              //         ).paddingSymmetric(
                              //             horizontal: ScreenDimensions.widthPercentage(context, 5),
                              //             vertical: ScreenDimensions.heightPercentage(context, 1)),
                              //       ),
                              //     ],
                              //   ),
                              // ),


                              // Positioned(
                              //   bottom: 1,
                              //   width: ScreenDimensions.screenWidth(context),
                              //   child: Column(
                              //     children: [
                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           SizedBox(
                              //             width: ScreenDimensions.widthPercentage(context, 90),
                              //             child: Text.rich(
                              //               TextSpan(
                              //                 children: [
                              //                   TextSpan(text: ' ${controller.model['country']} '),
                              //                   TextSpan(text: ' ${controller.model['state']} '),
                              //                   TextSpan(text: ' ${controller.model['city']} '),
                              //                   TextSpan(text: ' ${controller.model['neighborhood']} '),
                              //                   TextSpan(text: ' ${controller.model['street']} '),
                              //                 ],),
                              //               maxLines: 2,textAlign: TextAlign.center,
                              //               style: TextStyle(
                              //                   fontWeight: FontWeight.bold,
                              //                   fontSize: AppFonts.smallTitleFont(context)),
                              //             ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 1)),
                              //           ),
                              //           SvgPicture.asset(
                              //             AppImages.location,
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                            Directions(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      ' : ${AppWord.profileDescription}',
                                      maxLines: 10,
                                      style: TextStyle(
                                          fontSize: AppFonts.subTitleFont(context),
                                          fontWeight: FontWeight.bold),
                                    ).paddingSymmetric(
                                        horizontal: ScreenDimensions.widthPercentage(context, 2)),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.user!.description!,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: AppFonts.smallTitleFont(context),
                                          fontWeight: FontWeight.bold),
                                    ).paddingSymmetric(
                                        horizontal: ScreenDimensions.widthPercentage(context, 2)),
                                  ),
                                ],
                              ),
                            ).paddingSymmetric(
                                horizontal: ScreenDimensions.widthPercentage(context, 5),
                                vertical: ScreenDimensions.heightPercentage(context, 1)),
                        Center(
                            child: Container(
                              alignment: Alignment.center,
                              width: ScreenDimensions.widthPercentage(context, 80),
                              height: ScreenDimensions.heightPercentage(context, 25),
                              decoration: BoxDecoration(
                                color: CustomColors.gold,
                                borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 1),
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(const MyPurchasesHome(),duration: const Duration(milliseconds: 500),transition: Transition.zoom);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(AppImages.shop),
                                        SizedBox(
                                          width: ScreenDimensions.widthPercentage(context, 40),
                                          child: Text(
                                            AppWord.myPurchases,
                                            style: TextStyle(
                                                color: CustomColors.white,
                                              fontSize: AppFonts.subTitleFont(context),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 10)),
                                  ),
                                  Divider(color: Colors.white,thickness: ScreenDimensions.widthPercentage(context, 0.3)).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 3)),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(const MySellsHome(),duration: const Duration(milliseconds: 500),transition: Transition.zoom);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(AppImages.sells),
                                        SizedBox(
                                          width: ScreenDimensions.widthPercentage(context, 40),
                                          child: Text(
                                            AppWord.mySells,
                                            style: TextStyle(
                                              color: CustomColors.white,
                                              fontSize: AppFonts.subTitleFont(context),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 10)),
                                  ),
                                  Divider(color: Colors.white,thickness: ScreenDimensions.widthPercentage(context, 0.3)).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 3)),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(const MyAds(),duration: const Duration(milliseconds: 500),transition: Transition.zoom);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(AppImages.adds),
                                        SizedBox(
                                          width: ScreenDimensions.widthPercentage(context, 40),
                                          child: Text(
                                            AppWord.myAds,
                                            style: TextStyle(
                                              color: CustomColors.white,
                                              fontSize: AppFonts.subTitleFont(context),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 10)),
                                  ),
                                ],
                              ).marginSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                            ),
                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                        Directions(
                              child: Center(
                                child: AppButton(
                                    text: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppWord.editProfile,
                                          style: TextStyle(
                                              color: CustomColors.white,
                                              fontSize:
                                              AppFonts.smallTitleFont(context),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: ScreenDimensions.widthPercentage(
                                              context, 1),
                                        ),
                                        SvgPicture.asset(AppImages.edit,
                                            color: CustomColors.white),
                                      ],
                                    ),
                                    onTap: () {
                                      Get.to(const EditProfile(),
                                          transition: Transition.fade,
                                          duration:
                                          const Duration(milliseconds: 500));
                                    },
                                    buttonBackground:
                                    AppImages.buttonLiteBackground),
                              ),
                            ).paddingOnly(bottom: ScreenDimensions.heightPercentage(context, 1)),
                      ])),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
