// ignore_for_file: deprecated_member_use

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/edit_profile/view/edit_profile_view.dart';
import '../../../../../core/colors/colors.dart';
import '../../../../../core/images/images.dart';
import '../../mediator_shop_edit_profile/view/mediator_shop_edit_profile.dart';

class MediatorShopProfile extends StatelessWidget {
  const MediatorShopProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        body: SizedBox(
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
                              child: Icon(
                                Icons.person_2_outlined,
                                size: ScreenDimensions.heightPercentage(
                                    context, 10),
                              ),
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
                                AppWord.userName,
                                style: TextStyle(
                                  color: CustomColors.white,
                                  fontSize: AppFonts.subTitleFont(context),
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
                                    AppWord.activatedAccount,
                                    style: TextStyle(
                                      color: CustomColors.white,
                                      fontSize: AppFonts.subTitleFont(context),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenDimensions.widthPercentage(
                                        context, 2),
                                  ),
                                  Icon(Icons.verified,
                                      color: CustomColors.white,
                                      size: ScreenDimensions.widthPercentage(
                                          context, 6)),
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(AppWord.mediatorShopName,
                                  style: TextStyle(
                                      fontSize:
                                      AppFonts.smallTitleFont(
                                          context),
                                      fontWeight:
                                      FontWeight.bold)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('السعودية, المدينة المنورة , حي النبلاء',
                                      style: TextStyle(
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
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
                            ],
                          ).paddingSymmetric(horizontal:ScreenDimensions.widthPercentage(context, 2)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenDimensions.screenWidth(context),
                  height: ScreenDimensions.heightPercentage(context, 15),
                  decoration: BoxDecoration(border: Border.all()),
                ).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 2)),
                Directions(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '09958585757',
                        style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: ScreenDimensions.widthPercentage(context, 2),
                      ),
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
                        'username@gmail.com',
                        style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: ScreenDimensions.widthPercentage(context, 2),
                      ),
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
                      Text('50',
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
                Directions(
                    child: Text(
                  'الحلاق لبيع المجوهرات',
                  style: TextStyle(
                      fontSize: AppFonts.smallTitleFont(context),
                      fontWeight: FontWeight.bold),
                )).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 1),
                    horizontal: ScreenDimensions.widthPercentage(context, 10)),
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
                          Get.to(const MediatorShopEditProfile(),
                              transition: Transition.fade,
                              duration: const Duration(milliseconds: 500));
                        },
                        buttonBackground: AppImages.buttonLiteBackground),
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
