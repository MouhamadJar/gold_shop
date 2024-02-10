import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/my_sells/components/my_sells_components.dart';
import 'package:gold_shop/module/my_sells/controller/my_sells_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/components/components.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';
import '../my_sells_filter/view/my_sells_filter_view.dart';

class MySells extends GetView<MySellsController> {
  const MySells({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MySellsController());
    return GetBuilder<MySellsController>(
      initState: (state){
        controller.getMySells();
        controller.products.clear();
      },
      builder: (_) {
        return SizedBox(
          width: ScreenDimensions.screenWidth(context),
          height: ScreenDimensions.heightPercentage(context, 80),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const MySellsFilter(),
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
                            child: GetBuilder<MySellsController>(
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
                            child: GetBuilder<MySellsController>(
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
                            child: GetBuilder<MySellsController>(
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
                            child: GetBuilder<MySellsController>(
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
              const Expanded(child: MySellsCard()),
            ],
          ),
        );
      }
    );
  }
}
