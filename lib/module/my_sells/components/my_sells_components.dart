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
import 'package:gold_shop/module/my_sells/controller/my_sells_controller.dart';
import 'package:gold_shop/module/sold_product/view/sold_product_view.dart';

class MySellsCard extends GetView<MySellsController> {
  const MySellsCard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MySellsController());
    return GetBuilder<MySellsController>(builder: (_) {
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
              : ListView.builder(
          itemCount: controller.products.length,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(ScreenDimensions.widthPercentage(context, 5)),
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: () {
                Get.to(SoldProduct(productId: controller.products[index]['id'],),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500));
              },
              child: DelayedDisplay(
                slidingBeginOffset: const Offset(0, 1),
                delay: Duration(milliseconds: (index * 10) + 10),
                child: Container(
                  width: ScreenDimensions.widthPercentage(context, 40),
                  height: ScreenDimensions.heightPercentage(context, 20),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Directions(
                        child: SizedBox(
                          width: ScreenDimensions.widthPercentage(context, 40),
                          height: ScreenDimensions.heightPercentage(context, 20),
                          // padding: EdgeInsetsDirectional.symmetric(
                          //   horizontal: ScreenDimensions.widthPercentage(
                          //       context, 3),
                          // ),
                          // alignment: AlignmentDirectional.centerEnd,
                          // decoration: BoxDecoration(
                          //     color: CustomColors.white1,
                          //     borderRadius: BorderRadiusDirectional.only(
                          //         topStart: Radius.circular(
                          //           ScreenDimensions.widthPercentage(
                          //               context, 2),
                          //         ),
                          //         topEnd: Radius.circular(
                          //           ScreenDimensions.widthPercentage(
                          //               context, 2),
                          //         )),
                          //     border: Border.all()),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    ' ${controller.products[index]['carat']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppFonts.smallTitleFont(
                                          context),
                                    ),
                                  ),
                                  Text('  ${AppWord.caliber}',style:TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFonts.smallTitleFont(
                                        context),
                                  )),
                                  const Spacer(),
                                  Text(
                                    '${AppWord.grams} ${controller.products[index]['wight']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppFonts.smallTitleFont(
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${AppWord.sad} ${controller.products[index]['price'].toInt()}',
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
                      AppNetworkImage(
                        baseUrlImages + controller.products[index]['images'][0]['image'],
                        width: ScreenDimensions.widthPercentage(context, 35),
                        height: ScreenDimensions.heightPercentage(context, 35),
                      ),
                    ],
                  ),
                ),
              ),
            ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1));
          });
    });
  }
}
