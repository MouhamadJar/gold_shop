// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/storage_handler/storage_handler.dart';
import 'package:gold_shop/module/about_us/view/about_us_view.dart';
import 'package:gold_shop/module/authentication/view/user/verify_account_screen.dart';
import 'package:gold_shop/module/privacy/view/privacy_view.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/components/components.dart';
import '../../../../core/images/images.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../add_product/view/add_product_view.dart';
import '../../../authentication/view/login_screen.dart';
import '../../../categories/view/categories_view.dart';
import '../../../home/view/home_view.dart';
import '../../../map/view/mediator_shops_map_screen.dart';
import '../../../profile/view/profile_view.dart';
import '../components/components.dart';
import '../controller/controller.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainScreenController());
    List<Widget> screens = [
      const Profile(),
      const HomeScreen(),
      const Categories(),
      const AddProduct(),
    ];
    List<String> title = [
      AppWord.profile,
      AppWord.home,
      AppWord.categories,
      AppWord.add
    ];
    return GetBuilder<MainScreenController>(builder: (_) {
      return SafeArea(
        child: Scaffold(
          drawerEnableOpenDragGesture: true,
          backgroundColor: CustomColors.white,
          drawerEdgeDragWidth: ScreenDimensions.widthPercentage(context, 20),
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
                                height: ScreenDimensions.heightPercentage(
                                    context, 20),
                                width: ScreenDimensions.widthPercentage(
                                    context, 40),
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
                              height: ScreenDimensions.heightPercentage(
                                  context, 18),
                              width:
                                  ScreenDimensions.widthPercentage(context, 36),
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
                              width:
                                  ScreenDimensions.widthPercentage(context, 3),
                            ),
                            Icon(
                              Icons.verified,
                              color: CustomColors.white,
                              size: ScreenDimensions.radius(context, 3),
                            ),
                          ],
                        ),
                        DrawerListTiles(
                          title: StorageHandler().hasToken
                              ? AppWord.logout
                              : AppWord.login,
                          imagePath: AppImages.login,
                          onTap: StorageHandler().hasToken
                              ? () {
                                  controller.logout();
                                  Get.off(const MainScreen(),
                                      transition: Transition.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 700));
                                }
                              : () {
                                  Get.to(const LoginScreen(),
                                      transition: Transition.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 700));
                                },
                        ),
                        DrawerListTiles(
                          onTap: (){Get.to(const VerifyUserAccount(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 700));},
                            title: AppWord.activateAccount,
                            imagePath: AppImages.verified),
                        DrawerListTiles(
                            title: AppWord.add, imagePath: AppImages.add),
                        DrawerListTiles(
                          title: AppWord.mediatorShops,
                          imagePath: AppImages.map,
                          onTap: () {
                            Get.to(const MediatorShopsMapScreen());
                          },
                        ),
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
                          title: AppWord.info,
                          imagePath: AppImages.info,
                          onTap: () {
                            Get.to(const AboutUs(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 700));
                          },
                        ),
                        DrawerListTiles(
                          title: AppWord.contactUs,
                          imagePath: AppImages.contactUs2,
                        ),
                      ],
                    ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
              title[controller.currentIndex],
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
          bottomNavigationBar: Directions(
            child: SnakeNavigationBar.color(
              unselectedLabelStyle: TextStyle(
                fontSize: AppFonts.smallTitleFont(context) - 2,
                overflow: TextOverflow.ellipsis,
              ),
              shape: const StadiumBorder(),
              padding: EdgeInsets.only(
                  right: ScreenDimensions.widthPercentage(context, 2),
                  left: ScreenDimensions.widthPercentage(context, 2),
                  bottom: ScreenDimensions.heightPercentage(context, 1)),
              onTap: (currentIndex) {
                if (currentIndex == 0 || currentIndex == 3) {
                  if (!(StorageHandler().hasToken)) {
                    Get.dialog(
                        barrierDismissible: false,
                        Material(
                          color: Colors.transparent,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: WillPopScope(
                              onWillPop: () async {
                                return false;
                              },
                              child: Container(
                                width: ScreenDimensions.screenWidth(context),
                                height: ScreenDimensions.screenHeight(context),
                                padding: EdgeInsetsDirectional.all(
                                    ScreenDimensions.widthPercentage(
                                        context, 5)),
                                margin: EdgeInsetsDirectional.symmetric(
                                    horizontal:
                                        ScreenDimensions.widthPercentage(
                                            context, 5),
                                    vertical: ScreenDimensions.heightPercentage(
                                        context, 30)),
                                decoration: BoxDecoration(
                                    color: CustomColors.gold,
                                    borderRadius: BorderRadius.circular(
                                        ScreenDimensions.radius(context, 1))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.login,
                                      width: ScreenDimensions.widthPercentage(
                                        context,
                                        10,
                                      ),
                                    ),
                                    Text(
                                      AppWord.youHaveToLoginOrSignup,
                                      style: TextStyle(
                                        fontSize:
                                            AppFonts.subTitleFont(context),
                                        color: CustomColors.white,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(const LoginScreen(),
                                            transition: Transition.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 700));
                                      },
                                      child: Container(
                                        height:
                                            ScreenDimensions.heightPercentage(
                                                context, 5),
                                        width:
                                            ScreenDimensions.heightPercentage(
                                                context, 20),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: CustomColors.white,
                                            border: Border.all(),
                                            borderRadius: BorderRadius.circular(
                                                ScreenDimensions
                                                    .heightPercentage(
                                                        context, 1))),
                                        child: Text(AppWord.login,
                                            style: TextStyle(
                                                color: CustomColors.black,
                                                fontSize:
                                                    AppFonts.smallTitleFont(
                                                        context))),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
                    return;
                  }
                }
                controller.currentIndex = currentIndex;
                controller.update();
              },
              backgroundColor: CustomColors.black,
              showUnselectedLabels: true,
              unselectedItemColor: controller.unSelectedColor,
              snakeViewColor: CustomColors.white,
              currentIndex: controller.currentIndex,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppImages.user,
                    color: controller.currentIndex == 0
                        ? controller.selectedColor
                        : controller.unSelectedColor,
                  ),
                  label: AppWord.profile,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.home,
                      color: controller.currentIndex == 1
                          ? controller.selectedColor
                          : controller.unSelectedColor),
                  label: AppWord.home,
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppImages.categories,
                        color: controller.currentIndex == 2
                            ? controller.selectedColor
                            : controller.unSelectedColor),
                    label: AppWord.categories),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppImages.add,
                        color: controller.currentIndex == 3
                            ? controller.selectedColor
                            : controller.unSelectedColor),
                    label: AppWord.add),
              ],
              behaviour: SnakeBarBehaviour.floating,
            ),
          ),
          body: screens[controller.currentIndex],
        ),
      );
    });
  }
}
