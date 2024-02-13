import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/sort/controller/sort_controller.dart';

import '../../../core/texts/words.dart';

class SortScreen extends GetView<SortController> {
  const SortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SortController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: CustomColors.white,
          elevation: 1,
          leading: const SizedBox.shrink(),
          title: Text(
            AppWord.sortProducts,
            style: TextStyle(
                fontSize: AppFonts.subTitleFont(context),
                fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_forward,
                  size: ScreenDimensions.widthPercentage(context, 5),
                  color: CustomColors.black),
            )
          ],
        ),
        body: GetBuilder<SortController>(
          builder: (_) {
            return SizedBox(
              height: ScreenDimensions.screenHeight(context),
              width: ScreenDimensions.screenWidth(context),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppWord.price,
                        style: TextStyle(
                            color: CustomColors.black,
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: ScreenDimensions.widthPercentage(context, 10),),
                      Column(
                        children: [
                          Row(
                            children: [
                              GetBuilder<SortController>(
                                builder: (_) {
                                  return Checkbox(
                                      value: controller.priceLTH,
                                      onChanged: (value) {
                                        controller.priceLTH = value!;
                                        controller.priceHTL = false;
                                        controller.update();
                                        // controller.priceCheckLTH();
                                      },
                                      activeColor: CustomColors.gold);
                                }
                              ),
                              Text(
                                AppWord.lth,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              GetBuilder<SortController>(
                                builder: (_) {
                                  return Checkbox(
                                      value: controller.priceHTL,
                                      onChanged: (value) {
                                        controller.priceHTL= value!;
                                        controller.priceLTH= false;
                                        controller.update();
                                        // controller.priceCheckHTL();
                                      },
                                      activeColor: CustomColors.gold);
                                }
                              ),
                              Text(
                                AppWord.htl,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context)),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                  Row(
                    children: [
                      Text(
                        AppWord.weights,
                        style: TextStyle(
                            color: CustomColors.black,
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: ScreenDimensions.widthPercentage(context, 10),),
                      Column(
                        children: [
                          Row(
                            children: [
                              GetBuilder<SortController>(
                                builder: (_) {
                                  return Checkbox(
                                      value: controller.weightLTH,
                                      onChanged: (value) {
                                        controller.weightLTH=value!;
                                        controller.weightHTL=false;
                                        controller.update();
                                        // controller.weightCheckLTH();
                                      },
                                      activeColor: CustomColors.gold);
                                }
                              ),
                              Text(
                                AppWord.lth,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              GetBuilder<SortController>(
                                builder: (_) {
                                  return Checkbox(
                                      value: controller.weightHTL,
                                      onChanged: (value) {
                                        controller.weightHTL = value!;
                                        controller.weightLTH = false;
                                        controller.update();
                                        // controller.weightCheckHTL();
                                      },
                                      activeColor: CustomColors.gold);
                                }
                              ),
                              Text(
                                AppWord.htl,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context)),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                  Row(
                    children: [
                      Text(
                        AppWord.productCalibre,
                        style: TextStyle(
                            color: CustomColors.black,
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: ScreenDimensions.widthPercentage(context, 1),),
                      Column(
                        children: [
                          Row(
                            children: [
                              GetBuilder<SortController>(
                                builder: (_) {
                                  return Checkbox(
                                      value: controller.caratLTH,
                                      onChanged: (value) {
                                        controller.caratLTH= value!;
                                        controller.caratHTL= false;
                                        controller.update();
                                        // controller.caratCheckLTH();
                                      },
                                      activeColor: CustomColors.gold);
                                }
                              ),
                              Text(
                                AppWord.lth,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              GetBuilder<SortController>(
                                builder: (_) {
                                  return Checkbox(
                                      value: controller.caratHTL,
                                      onChanged: (value) {
                                        controller.caratHTL= value!;
                                        controller.caratLTH= false;
                                        controller.update();
                                        },
                                      activeColor: CustomColors.gold);
                                }
                              ),
                              Text(
                                AppWord.htl,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context)),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                  const Spacer(),
                  AppButton(
                      text: Text(
                        AppWord.search,
                        style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold,
                            color: CustomColors.white),
                      ),
                      onTap: () {
                        controller.htlValuesCheck();
                        controller.sort();
                        },
                      buttonBackground: AppImages.buttonLiteBackground)
                ],
              ).paddingSymmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 4),
                  vertical: ScreenDimensions.heightPercentage(context, 2)),
            );
          }
        ),
      ),
    );
  }
}
