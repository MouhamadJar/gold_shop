import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/my_purchases/components/my_purchases_components.dart';
import 'package:gold_shop/module/my_purchases/controller/my_purchases_controller.dart';
import 'package:gold_shop/module/my_purchases/my_purchases_filter/controller/my_purchases_filter_controller.dart';

import '../../../core/components/components.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../my_purchases_filter/view/my_purchases_filter_view.dart';

class MyPurchases extends GetView<MyPurchasesController> {
  const MyPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyPurchasesController());
    return GetBuilder<MyPurchasesController>(
      initState:  (state){
        controller.getMyPurchases();
        controller.products.clear();
      },
      builder: (_) {
        return SizedBox(
          height: ScreenDimensions.heightPercentage(context, 80),
          width: ScreenDimensions.screenWidth(context),
          child: Column(
            children: [
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
                            child: GetBuilder<MyPurchasesController>(
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
                            child: GetBuilder<MyPurchasesController>(
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
                            child: GetBuilder<MyPurchasesController>(
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
                            child: GetBuilder<MyPurchasesController>(
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
              ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
              const Expanded(child: PurchasesCard()),
            ],
          ),
        );
      }
    );
  }
}
