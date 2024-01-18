import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/authentication/view/mediator_shop/verify_account_screen.dart';
import 'package:gold_shop/module/main/mediator_shop/mediator_shop_profile/view/mediator_shop_profile.dart';
import 'package:gold_shop/module/main/mediator_shop/product_code/view/product_code_view.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/components/components.dart';
import '../../../../core/images/images.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../authentication/view/login_screen.dart';
import '../../../map/view/mediator_shops_map_screen.dart';
import '../../user/components/components.dart';

class MediatorShopHome extends StatelessWidget {
  const MediatorShopHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        backgroundColor: CustomColors.white,
        drawerEdgeDragWidth: ScreenDimensions.widthPercentage(context, 20),
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.all(
                  ScreenDimensions.widthPercentage(context, 2)),
              child: SvgPicture.asset(
                AppImages.saudiArabia,
                height: ScreenDimensions.heightPercentage(context, 5),
              ),
            ),
          ],
          centerTitle: true,
          title: Text(
            AppWord.home,
            style: TextStyle(
              color: CustomColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.subTitleFont(context),
            ),
          ),
          leading: Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: SvgPicture.asset(
                AppImages.moreIcon,
                fit: BoxFit.scaleDown,
              ),
            );
          }),
          elevation: 1,
          backgroundColor: CustomColors.white,
        ),
        drawer: Directions(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Drawer(
              width: ScreenDimensions.widthPercentage(context, 65),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [CustomColors.gold, CustomColors.black],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      stops: const [0.5, 1]),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                              height:
                                  ScreenDimensions.heightPercentage(context, 20),
                              width:
                                  ScreenDimensions.widthPercentage(context, 40),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                      color: CustomColors.shadow,
                                    )
                                  ])),
                          Container(
                            height:
                                ScreenDimensions.heightPercentage(context, 18),
                            width: ScreenDimensions.widthPercentage(context, 36),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person_2_outlined,
                                size: ScreenDimensions.heightPercentage(
                                    context, 15)),
                          ),
                        ],
                      ),
                      Text(
                        AppWord.userName,
                        style: TextStyle(
                            fontSize: AppFonts.subTitleFont(context),
                            color: CustomColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppWord.activatedAccount,
                            style: TextStyle(
                                fontSize: AppFonts.subTitleFont(context),
                                color: CustomColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: ScreenDimensions.widthPercentage(context, 3),
                          ),
                          Icon(
                            Icons.verified,
                            color: CustomColors.white,
                            size: ScreenDimensions.radius(context, 3),
                          ),
                        ],
                      ),
                      DrawerListTiles(
                        title: AppWord.logout,
                        imagePath: AppImages.login,
                        onTap: () {
                          Get.to(const LoginScreen());
                        },
                      ),
                      DrawerListTiles(
                          onTap: () {
                            Get.to(const VerifyMediatorAccount(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 700));
                          },
                          title: AppWord.activateAccount,
                          imagePath: AppImages.verified),
                      DrawerListTiles(
                        onTap: (){Get.to(const MediatorShopProfile(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 700));},
                          title: AppWord.profile, imagePath: AppImages.user),
                      DrawerListTiles(
                        title: AppWord.language,
                        imagePath: AppImages.language,
                        onTap: () {
                          Get.log(Get.locale!.languageCode);
                          if (Get.locale!.languageCode == 'ar') {
                            Get.updateLocale(const Locale('en'));
                          } else {
                            Get.updateLocale(const Locale('ar'));
                          }
                        },
                      ),
                      DrawerListTiles(
                          title: AppWord.notifications,
                          imagePath: AppImages.notification),
                      DrawerListTiles(
                          title: AppWord.deal, imagePath: AppImages.contract),
                      DrawerListTiles(
                          title: AppWord.info, imagePath: AppImages.info),
                      DrawerListTiles(
                          title: AppWord.contactUs,
                          imagePath: AppImages.contactUs2),
                    ],
                  ).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 2),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                AppWord.eSignaturePic,
                style: TextStyle(
                    shadows: [Shadow(blurRadius: 3, color: CustomColors.shadow)],
                    color: CustomColors.yellow,
                    fontSize: AppFonts.subTitleFont(context),
                    fontWeight: FontWeight.bold),
              ),
            ).paddingSymmetric(
                horizontal: ScreenDimensions.heightPercentage(context, 3),
                vertical: ScreenDimensions.heightPercentage(context, 3)),
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                alignment: AlignmentDirectional.center,
                height: ScreenDimensions.heightPercentage(context, 7),
                width: ScreenDimensions.widthPercentage(context, 60),
                decoration: BoxDecoration(
                    color: CustomColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: CustomColors.shadow,
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer,
                          offset: const Offset(0, 3),
                          spreadRadius: 0.1),
                    ],
                    borderRadius: BorderRadius.circular(
                        ScreenDimensions.radius(context, 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppWord.uploadPicture,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFonts.smallTitleFont(context),
                      ),
                    ),
                    SvgPicture.asset(
                      AppImages.upload,
                      height: ScreenDimensions.heightPercentage(context, 2.5),
                    ),
                  ],
                ),
              ),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 4)),
            const Spacer(),
            AppButton(
                text: Text(
                  AppWord.done,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFonts.smallTitleFont(context),
                      color: CustomColors.white),
                ),
                onTap: () {
                  Get.to(const ProductCode(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 700));
                },
                buttonBackground: AppImages.buttonLiteBackground).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
          ],
        ),
      ),
    );
  }
}
