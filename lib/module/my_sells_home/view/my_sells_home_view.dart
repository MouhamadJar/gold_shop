import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/my_put_aside_sells/view/my_put_aside_sells_view.dart';
import 'package:gold_shop/module/my_reserved_sells/view/my_reserved_sells_view.dart';
import 'package:gold_shop/module/my_sells_home/controller/my_sells_home_controller.dart';

import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../my_sells/my_sells_filter/view/my_sells_filter_view.dart';
import '../../my_sells/view/my_sells_view.dart';

class MySellsHome extends GetView<MySellsHomeController> {
  const MySellsHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MySellsHomeController());
    List<Widget> screens = [
      const MySells(),
      const MyReservedSells(),
      const MyPutAsideSells(),
    ];
    List<String> title = [
      AppWord.sold,
      AppWord.myReservedSells,
      AppWord.myPutAsideSells,
    ];
    return GetBuilder<MySellsHomeController>(builder: (_) {
      return SafeArea(
          child: Directions(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: CustomColors.white,
          appBar: AppBar(
              backgroundColor: CustomColors.white,
              elevation: 1,
              centerTitle: true,
              title: Text(
                AppWord.mySells,
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
                  controller.index == 1
                      ? Container(
                          alignment: AlignmentDirectional.center,
                          width: ScreenDimensions.screenWidth(context),
                          height:
                              ScreenDimensions.heightPercentage(context, 7),
                          decoration: BoxDecoration(
                              color: Colors.yellow[100], border: Border.all(color: CustomColors.gold)),
                          child: Text(
                            AppWord.payingApprovedForReservedProducts,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: AppFonts.smallTitleFont(context)),
                          ),
                        )
                      : controller.index == 2
                          ? Container(
                              alignment: AlignmentDirectional.center,
                              width: ScreenDimensions.screenWidth(context),
                              height: ScreenDimensions.heightPercentage(
                                  context, 7),
                              decoration: BoxDecoration(
                                  color: Colors.yellow[100],
                                  border: Border.all(color: CustomColors.gold)),
                              child: Text(
                                AppWord.payingNotApprovedForPutAsideProducts,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context)),
                              ),
                            )
                          : const SizedBox.shrink(),
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
                              fontSize: AppFonts.smallTitleFont(context)),
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
                                              onTap: () {},
                                              child: Text(
                                                AppWord.yes,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppFonts.smallTitleFont(
                                                            context)),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
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
