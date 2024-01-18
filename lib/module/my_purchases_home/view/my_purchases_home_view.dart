import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/my_purchases/view/my_purchases_view.dart';
import 'package:gold_shop/module/my_purchases_home/controller/my_purchases_home_controller.dart';
import 'package:gold_shop/module/my_put_aside_purchases/view/my_put_aside_purchases_view.dart';
import 'package:gold_shop/module/my_reserved_purchases/view/my_reserved_purchases_view.dart';

import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../my_purchases_filter/view/my_purchases_filter_view.dart';

class MyPurchasesHome extends GetView<MYPurchasesHomeController> {
  const MyPurchasesHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MYPurchasesHomeController());
    List<Widget> screens = [
      const MyPurchases(),
      const MyReservedPurchases(),
      const MyPutAsidePurchases(),
    ];
    List<String> title = [
      AppWord.myPurchases,
      AppWord.myReservedPurchases,
      AppWord.myPutAsidePurchases,
    ];
    return GetBuilder<MYPurchasesHomeController>(builder: (_) {
      return SafeArea(
          child: Directions(
        child: Scaffold(
          backgroundColor: CustomColors.white,
          appBar: AppBar(
              backgroundColor: CustomColors.white,
              elevation: 1,
              centerTitle: true,
              title: Text(
                title[0],
                style: TextStyle(
                    color: CustomColors.black,
                    fontSize: AppFonts.subTitleFont(context),
                    fontWeight: FontWeight.bold),
              )),
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Column(
                children: [
                  SnakeNavigationBar.color(
                    onTap: (index) {
                      controller.index = index;
                      controller.update();
                    },
                    currentIndex: controller.index,
                    height: ScreenDimensions.heightPercentage(context, 6),
                    backgroundColor: CustomColors.white,
                    elevation: 3,
                    padding: EdgeInsets.all(
                        ScreenDimensions.widthPercentage(context, 1)),
                    snakeShape: SnakeShape.indicator,
                    snakeViewColor: CustomColors.yellow,
                    items: [
                      BottomNavigationBarItem(
                        icon: Text(
                          title[0],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: controller.index == 0
                                  ? CustomColors.gold
                                  : CustomColors.black,
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Text(
                          title[1],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: controller.index == 1
                                  ? CustomColors.gold
                                  : CustomColors.black,
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Text(
                          title[2],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: controller.index == 2
                                  ? CustomColors.gold
                                  : CustomColors.black,
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(const MyPurchasesFilter(),
                              transition: Transition.zoom,
                              duration: const Duration(milliseconds: 300));
                        },
                        child: SvgPicture.asset(
                          AppImages.filter,
                          height: ScreenDimensions.heightPercentage(context, 2),
                        ),
                      ),
                      Directions(
                        child: PopupMenuButton(
                          color: CustomColors.white,
                          elevation: 1,
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                child: GetBuilder<MYPurchasesHomeController>(
                                    builder: (_) {
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: controller.dateIsChecked,
                                        onChanged: (value) {
                                          controller.dateCheck();
                                          controller.dateIsChecked = value!;
                                          Get.back();
                                        },
                                        activeColor: CustomColors.gold,
                                      ),
                                      Text(
                                        AppWord.otn,
                                        style: TextStyle(
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ),
                              PopupMenuItem(
                                child: GetBuilder<MYPurchasesHomeController>(
                                    builder: (_) {
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: !controller.dateIsChecked,
                                        onChanged: (value) {
                                          controller.dateCheck();
                                          controller.dateIsChecked = !value!;
                                          Get.back();
                                        },
                                        activeColor: CustomColors.gold,
                                      ),
                                      Text(
                                        AppWord.nto,
                                        style: TextStyle(
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ];
                          },
                          child: Row(
                            children: [
                              Text(
                                AppWord.sortByDate,
                                style: TextStyle(
                                  color: CustomColors.black,
                                  fontSize: AppFonts.smallTitleFont(context),
                                ),
                              ),
                              SizedBox(
                                width: ScreenDimensions.widthPercentage(
                                    context, 2),
                              ),
                              SvgPicture.asset(
                                AppImages.sort,
                                height: ScreenDimensions.heightPercentage(
                                    context, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Directions(
                        child: PopupMenuButton(
                          color: CustomColors.white,
                          elevation: 1,
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                child: GetBuilder<MYPurchasesHomeController>(
                                    builder: (_) {
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: controller.priceIsChecked,
                                        onChanged: (value) {
                                          controller.priceCheck();
                                          controller.priceIsChecked = value!;
                                          Get.back();
                                        },
                                        activeColor: CustomColors.gold,
                                      ),
                                      Text(
                                        AppWord.htl,
                                        style: TextStyle(
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ),
                              PopupMenuItem(
                                child: GetBuilder<MYPurchasesHomeController>(
                                    builder: (_) {
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: !controller.priceIsChecked,
                                        onChanged: (value) {
                                          controller.priceCheck();
                                          controller.priceIsChecked = !value!;
                                          Get.back();
                                        },
                                        activeColor: CustomColors.gold,
                                      ),
                                      Text(
                                        AppWord.lth,
                                        style: TextStyle(
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ];
                          },
                          child: Row(
                            children: [
                              Text(
                                AppWord.sortByPrice,
                                style: TextStyle(
                                  color: CustomColors.black,
                                  fontSize: AppFonts.smallTitleFont(context),
                                ),
                              ),
                              SizedBox(
                                width: ScreenDimensions.widthPercentage(
                                    context, 2),
                              ),
                              SvgPicture.asset(
                                AppImages.sort,
                                height: ScreenDimensions.heightPercentage(
                                    context, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                  screens[controller.index],
                ],
              ),
              Positioned(
                bottom: 0,
                child: AppButton(
                        text: Text(
                          AppWord.printReport,
                          style: TextStyle(
                            color: CustomColors.white,
                            fontSize: AppFonts.smallTitleFont(context),
                          ),
                        ),
                        onTap: () {
                          Get.dialog(
                            Material(
                              color: Colors.transparent,
                              child: Directions(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    margin: EdgeInsetsDirectional.only(
                                        start: ScreenDimensions.widthPercentage(
                                            context, 5),
                                        end: ScreenDimensions.widthPercentage(
                                            context, 5),
                                        top: ScreenDimensions.heightPercentage(
                                            context, 5),
                                        bottom:
                                            ScreenDimensions.heightPercentage(
                                                context, 70)),
                                    color: CustomColors.white,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: SvgPicture.asset(
                                                AppImages.x,
                                                width: ScreenDimensions
                                                    .widthPercentage(
                                                        context, 3),
                                              ),
                                            ).paddingAll(ScreenDimensions
                                                .widthPercentage(context, 4)),
                                          ],
                                        ).paddingSymmetric(
                                            vertical: ScreenDimensions
                                                .heightPercentage(context, 1)),
                                        Text(
                                          AppWord.doYouWantToPrintReport,
                                          style: TextStyle(
                                              fontSize: AppFonts.smallTitleFont(
                                                  context),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: (){},
                                              child: Text(
                                                AppWord.yes,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppFonts.smallTitleFont(
                                                            context)),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                Get.back();
                                              },
                                              child: Text(
                                                AppWord.no,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppFonts.smallTitleFont(
                                                            context)),
                                              ),
                                            ),
                                          ],
                                        ).paddingSymmetric(
                                            vertical: ScreenDimensions
                                                .heightPercentage(context, 3)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        buttonBackground: AppImages.buttonLiteBackground)
                    .paddingSymmetric(
                        vertical:
                            ScreenDimensions.heightPercentage(context, 1)),
              ),
            ],
          ),
        ),
      ));
    });
  }
}
