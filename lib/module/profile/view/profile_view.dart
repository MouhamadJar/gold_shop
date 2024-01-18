// ignore_for_file: deprecated_member_use

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/edit_profile/view/edit_profile_view.dart';
import 'package:gold_shop/module/my_ads/view/my_ads_view.dart';
import 'package:gold_shop/module/profile/controller/profile_controller.dart';
import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: ScreenDimensions.screenWidth(context),
                          height: ScreenDimensions.heightPercentage(context, 60),
                          child: Stack(
                            children: [
                              Positioned(
                                top: ScreenDimensions.heightPercentage(context, 20),
                                left: -ScreenDimensions.widthPercentage(context, 30),
                                right: -ScreenDimensions.widthPercentage(context, 30),
                                child: Transform.rotate(
                                  angle: -120,
                                  child: Container(
                                    width: ScreenDimensions.screenWidth(context),
                                    height: ScreenDimensions.heightPercentage(context, 20),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          CustomColors.black,
                                          CustomColors.gold,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: ScreenDimensions.heightPercentage(context, 6),
                                  child: CircleAvatar(
                                    backgroundColor: CustomColors.white,
                                    radius: ScreenDimensions.radius(context, 10),
                                  )),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: ScreenDimensions.heightPercentage(context, 7),
                                  child: CircleAvatar(
                                    backgroundColor: CustomColors.white1,
                                    radius: ScreenDimensions.radius(context, 9),
                                    child: DelayedDisplay(
                                      delay: const Duration(milliseconds: 100),
                                      slidingBeginOffset: const Offset(0, 5),
                                      child: controller.model['photo']!=null
                                          ?AppNetworkImage(controller.model['photo'],shape:BoxShape.circle,)
                                          :Icon(Icons.person_2_outlined,
                                        size: ScreenDimensions.heightPercentage(context, 10),
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
                                        '${controller.model['first_name']} ${controller.model['last_name']}',
                                        style: TextStyle(
                                          color: CustomColors.white,
                                          fontSize:
                                              AppFonts.subTitleFont(context),
                                        ),
                                      ),
                                    ),
                                    DelayedDisplay(
                                      delay: const Duration(milliseconds: 600),
                                      slidingBeginOffset: const Offset(-5, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.model['is_verified']==0?AppWord.notActivatedAccount:AppWord.activatedAccount,
                                            style: TextStyle(
                                              color: CustomColors.white,
                                              fontSize: AppFonts.subTitleFont(
                                                  context),
                                            ),
                                          ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 3)),
                                          controller.model['is_verified']==0
                                              ?const SizedBox.shrink()
                                              :Icon(Icons.verified,
                                              color: CustomColors.white,
                                              size: ScreenDimensions.widthPercentage(context, 6)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 1,
                                child: Directions(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          '${controller.model['country']}, ${controller.model['state']} , ${controller.model['city']}',
                                          style: TextStyle(
                                              fontSize: AppFonts.smallTitleFont(
                                                  context),
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: ScreenDimensions.widthPercentage(
                                            context, 1),
                                      ),
                                      SvgPicture.asset(
                                        AppImages.location,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenDimensions.screenWidth(context),
                          height: ScreenDimensions.heightPercentage(context, 15),
                          decoration: BoxDecoration(border: Border.all()),
                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                        Directions(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.model['phone_number'],
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold),
                              ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 2)),
                              SvgPicture.asset(AppImages.phone)
                            ],
                          ),
                        ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5),
                            vertical: ScreenDimensions.heightPercentage(context, 1)),
                        Directions(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.model['email'],
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold),
                              ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 2)),
                              SvgPicture.asset(AppImages.email)
                            ],
                          ),
                        ).paddingSymmetric(
                            horizontal: ScreenDimensions.widthPercentage(context, 5),
                            vertical: ScreenDimensions.heightPercentage(context, 1)),
                        Directions(
                            child: Text(
                              controller.model['description'].toString(),
                          style: TextStyle(
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        )).paddingSymmetric(
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1),
                            horizontal:
                                ScreenDimensions.widthPercentage(context, 10)),
                        Text(
                          AppWord.myPurchasesAndPutAside,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    blurRadius: 3, color: CustomColors.shadow)
                              ],
                              color: CustomColors.yellow,
                              fontSize: AppFonts.subTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.heightPercentage(context, 2),
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1)),
                        SizedBox(
                            width: ScreenDimensions.screenWidth(context),
                            height:
                                ScreenDimensions.heightPercentage(context, 22),
                            child: const ProfileLists()),
                        TextButton(
                                onPressed: () {
                                  Get.to(const MyPurchasesHome(),
                                      transition: Transition.zoom,
                                      duration:
                                          const Duration(milliseconds: 500));
                                },
                                child: Text(
                                  AppWord.viewAll,
                                  style: TextStyle(
                                      color: CustomColors.black,
                                      fontSize:
                                          AppFonts.smallTitleFont(context)),
                                ))
                            .paddingSymmetric(
                                horizontal: ScreenDimensions.widthPercentage(
                                    context, 2)),
                        Text(
                          AppWord.mySellsAndPutAside,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    blurRadius: 3, color: CustomColors.shadow)
                              ],
                              color: CustomColors.yellow,
                              fontSize: AppFonts.subTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.heightPercentage(context, 2),
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1)),
                        SizedBox(
                            width: ScreenDimensions.screenWidth(context),
                            height:
                                ScreenDimensions.heightPercentage(context, 22),
                            child: const ProfileLists()),
                        TextButton(
                                onPressed: () {
                                  Get.to(const MySellsHome(),
                                      transition: Transition.zoom,
                                      duration:
                                          const Duration(milliseconds: 500));
                                },
                                child: Text(
                                  AppWord.viewAll,
                                  style: TextStyle(
                                      color: CustomColors.black,
                                      fontSize:
                                          AppFonts.smallTitleFont(context)),
                                ))
                            .paddingSymmetric(
                                horizontal: ScreenDimensions.widthPercentage(
                                    context, 2)),
                        Text(
                          AppWord.myAds,
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    blurRadius: 3, color: CustomColors.shadow)
                              ],
                              color: CustomColors.yellow,
                              fontSize: AppFonts.subTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.heightPercentage(context, 2),
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1)),
                        SizedBox(
                            width: ScreenDimensions.screenWidth(context),
                            height:
                                ScreenDimensions.heightPercentage(context, 22),
                            child: const ProfileLists()),
                        TextButton(
                                onPressed: () {
                                  Get.to(const MyAds(),
                                      transition: Transition.zoom,
                                      duration:
                                          const Duration(milliseconds: 500));
                                },
                                child: Text(
                                  AppWord.viewAll,
                                  style: TextStyle(
                                      color: CustomColors.black,
                                      fontSize:
                                          AppFonts.smallTitleFont(context)),
                                ))
                            .paddingSymmetric(
                                horizontal: ScreenDimensions.widthPercentage(
                                    context, 2)),
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
                        )
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
