// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/components/maps.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/edit_profile/view/edit_profile_view.dart';
import '../../../../../core/colors/colors.dart';
import '../../../../../core/images/images.dart';
import '../../mediator_shop_edit_profile/view/mediator_shop_edit_profile.dart';
import '../controller/mediator_shop_profile_controller.dart';

class MediatorShopProfile extends GetView<MediatorProfileController> {
  const MediatorShopProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MediatorProfileController());
    return SafeArea(
      child: Directions(
        child: Scaffold(
          backgroundColor: CustomColors.white,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: CustomColors.white,
            centerTitle: true,
            title: Text(AppWord.profile,
                style: TextStyle(
                    fontSize: AppFonts.subTitleFont(context),
                    fontWeight: FontWeight.bold)),
          ),
          body: GetBuilder<MediatorProfileController>(
            builder: (_) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator(color: CustomColors.gold,),)
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
                                  height:
                                      ScreenDimensions.heightPercentage(context, 20),
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
                                  child: controller.model!.photo == null || controller.model!.photo!.isEmpty
                                      ?Icon(
                                    Icons.person_2_outlined,
                                    size: ScreenDimensions.heightPercentage(
                                        context, 10),
                                  )
                                      :GestureDetector(
                                    onTap: (){
                                      Get.dialog(BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaY: 10, sigmaX: 10),
                                        child: InteractiveViewer(
                                          child: AppNetworkImage(
                                            baseUrlImages + controller.model!.photo!,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ));
                                    },
                                        child: AppNetworkImage(
                                          baseUrlImages + controller.model!.photo!,
                                          shape: BoxShape.circle,
                                          height: ScreenDimensions.heightPercentage(context, 20),
                                          width: ScreenDimensions.widthPercentage(context, 40),
                                          fit: BoxFit.contain,),
                                      ),
                                )),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: ScreenDimensions.heightPercentage(context, 26),
                              child: Column(
                                children: [
                                  DelayedDisplay(
                                    delay: const Duration(milliseconds: 300),
                                    slidingBeginOffset: const Offset(5, 0),
                                    child: Text(
                                      controller.model!.name,
                                      style: TextStyle(
                                        color: CustomColors.white,
                                        fontSize: AppFonts.subTitleFont(context),
                                      ),
                                    ),
                                  ),
                                  DelayedDisplay(
                                    delay: const Duration(milliseconds: 600),
                                    slidingBeginOffset: const Offset(-5, 0),
                                    child: controller.model!.isVerified == 1
                                        ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.verified,
                                            color: CustomColors.white,
                                            size: ScreenDimensions.widthPercentage(
                                                context, 6)),
                                        SizedBox(
                                          width: ScreenDimensions.widthPercentage(
                                              context, 2),
                                        ),
                                        Text(
                                          AppWord.activatedAccount,
                                          style: TextStyle(
                                            color: CustomColors.white,
                                            fontSize: AppFonts.subTitleFont(context),
                                          ),
                                        ),
                                      ],
                                    )
                                        : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppWord.notActivatedAccount,
                                          style: TextStyle(
                                            color: CustomColors.white,
                                            fontSize: AppFonts.subTitleFont(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              child: Directions(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: ScreenDimensions.widthPercentage(context, 90),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(text: ' ${controller.model!.country} '),
                                                TextSpan(text: ' ${controller.model!.state} '),
                                                TextSpan(text: ' ${controller.model!.city} '),
                                                TextSpan(text: ' ${controller.model!.neighborhood} '),
                                                TextSpan(text: ' ${controller.model!.street} '),
                                              ],),
                                            maxLines: 2,textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppFonts.smallTitleFont(context)),
                                          ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 1)),
                                        ),
                                        SvgPicture.asset(
                                          AppImages.location,
                                        ),
                                      ],
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal:ScreenDimensions.widthPercentage(context, 2)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppGoogleMap(markers: {controller.marker!},cameraPosition: controller.position,).paddingSymmetric(
                          vertical: ScreenDimensions.heightPercentage(context, 2)).marginSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 2)),
                      Directions(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              controller.model!.phoneNumber,
                              style: TextStyle(
                                  fontSize: AppFonts.smallTitleFont(context),
                                  fontWeight: FontWeight.bold),
                            ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 2)),
                            SvgPicture.asset(AppImages.phone)
                          ],
                        ),
                      ).paddingSymmetric(
                          horizontal: ScreenDimensions.widthPercentage(context, 5),
                          vertical: ScreenDimensions.heightPercentage(context, 1)),
                      Directions(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              controller.model!.email,
                              style: TextStyle(
                                  fontSize: AppFonts.smallTitleFont(context),
                                  fontWeight: FontWeight.bold),
                            ).paddingSymmetric(horizontal:ScreenDimensions.widthPercentage(context, 2)),
                            SvgPicture.asset(AppImages.email)
                          ],
                        ),
                      ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5), vertical: ScreenDimensions.heightPercentage(context, 1)),
                      Directions(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(AppWord.sad,
                                style: TextStyle(
                                    fontSize:
                                    AppFonts.smallTitleFont(
                                        context),
                                    fontWeight:
                                    FontWeight.bold)),
                            SizedBox(width: ScreenDimensions.widthPercentage(context, 1),),
                            Text(controller.model!.cost.toString(),
                                style: TextStyle(
                                    fontSize:
                                    AppFonts.smallTitleFont(
                                        context),
                                    fontWeight:
                                    FontWeight.bold)),
                            const Spacer(),
                            Text(
                              AppWord.shopCommissionForCheckService,
                              style: TextStyle(
                                  fontSize: AppFonts.smallTitleFont(context),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5), vertical: ScreenDimensions.heightPercentage(context, 1)),
                      SizedBox(
                        width: ScreenDimensions.screenWidth(context),
                        child: Text(
                          controller.model!.description,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context),
                          fontWeight: FontWeight.bold),
                                              ).paddingSymmetric(
                            vertical: ScreenDimensions.heightPercentage(context, 1),
                            horizontal: ScreenDimensions.widthPercentage(context, 10)),
                      ),
                      Center(
                        child: AppButton(
                            text: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppWord.editProfile,
                                  style: TextStyle(
                                      color: CustomColors.white,
                                      fontSize: AppFonts.smallTitleFont(context),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      ScreenDimensions.widthPercentage(context, 1),
                                ),
                                SvgPicture.asset(AppImages.edit,
                                    color: CustomColors.white),
                              ],
                            ),
                            onTap: () {
                              Get.to(
                                  const MediatorShopEditProfile(),
                                  transition: Transition.fade,
                                  duration: const Duration(milliseconds: 500));
                            },
                            buttonBackground: AppImages.buttonLiteBackground),
                      ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
