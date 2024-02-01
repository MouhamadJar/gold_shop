// ignore_for_file: non_constant_identifier_names

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/ads_product/view/ads_product_view.dart';
import 'package:gold_shop/module/my_ads/controller/my_ads_controller.dart';

class MyAdsCard extends GetView<MyAdsController> {
  const MyAdsCard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyAdsController());
    return GetBuilder<MyAdsController>(builder: (_) {
      return controller.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: CustomColors.gold,
              ),
            )
          : controller.products.isEmpty
              ? Center(
                  child: Text(
                  AppWord.nothingToShow,
                  style: TextStyle(fontSize: AppFonts.subTitleFont(context)),
                ))
              : GridView.builder(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 5),
                    vertical: ScreenDimensions.heightPercentage(context, 2),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing:
                        ScreenDimensions.heightPercentage(context, 4),
                    mainAxisSpacing:
                        ScreenDimensions.widthPercentage(context, 2),
                    mainAxisExtent:
                        ScreenDimensions.heightPercentage(context, 25),
                    // childAspectRatio: ScreenDimensions.heightPercentage(context, 0.06),
                    crossAxisCount: 2,
                  ),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Get.to(
                          AdsProduct(
                            productId: controller.products[index]['id'],
                          ),
                          transition: Transition.fadeIn,
                          duration: const Duration(milliseconds: 500));
                    },
                    child: DelayedDisplay(
                      slidingBeginOffset: const Offset(0, 1),
                      delay: Duration(milliseconds: (index * 10) + 10),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Positioned(
                            width:
                                ScreenDimensions.widthPercentage(context, 40),
                            top: ScreenDimensions.heightPercentage(context, 3),
                            height:
                                ScreenDimensions.heightPercentage(context, 20),
                            child: Directions(
                              child: Container(
                                padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 3),
                                ),
                                alignment: AlignmentDirectional.centerEnd,
                                decoration: BoxDecoration(
                                    color: CustomColors.white1,
                                    borderRadius: BorderRadiusDirectional.only(
                                        topStart: Radius.circular(
                                          ScreenDimensions.widthPercentage(
                                              context, 2),
                                        ),
                                        topEnd: Radius.circular(
                                          ScreenDimensions.widthPercentage(
                                              context, 2),
                                        )),
                                    border: Border.all()),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.products[index]['description'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            AppFonts.smallTitleFont(context),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 2,
                                    ).paddingOnly(
                                        bottom:
                                            ScreenDimensions.heightPercentage(
                                                context, 1)),
                                    Row(
                                      children: [
                                        Text(
                                          '${AppWord.caliber} ${controller.products[index]['carat']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppFonts.smallTitleFont(
                                                context),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${AppWord.grams} ${controller.products[index]['wight'].toInt()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppFonts.smallTitleFont(
                                                context),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${AppWord.sad} ${controller.products[index]['price']}',
                                      style: TextStyle(
                                        color: CustomColors.gold,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            AppFonts.smallTitleFont(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: ScreenDimensions.heightPercentage(context, 0),
                            width:
                                ScreenDimensions.widthPercentage(context, 20),
                            child: AppNetworkImage(baseUrlImages +
                                controller.products[index]['images'][0]
                                    ['image']),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
    });
  }
}
