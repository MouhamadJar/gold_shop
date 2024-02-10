// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/category_products/controller/category_products_controller.dart';
import 'package:gold_shop/module/product_details/view/product_details_view.dart';

import '../../../core/images/images.dart';
import '../../../core/storage_handler/storage_handler.dart';
import '../../authentication/view/login_screen.dart';
import '../../main/user/view/main_screen_view.dart';

class ProductsCard extends GetView<SubcategoryProductsController> {
  const ProductsCard({super.key, required this.subcategoryId});

  final int subcategoryId;

  @override
  Widget build(BuildContext context) {
    Get.put(SubcategoryProductsController());
    return GetBuilder<SubcategoryProductsController>(initState: (state) {
      controller.getAllProducts(subcategoryId: subcategoryId);
    }, builder: (_) {
      return GridView.builder(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: ScreenDimensions.widthPercentage(context, 5),
          vertical: ScreenDimensions.heightPercentage(context, 2),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: ScreenDimensions.heightPercentage(context, 4),
          mainAxisSpacing: ScreenDimensions.widthPercentage(context, 2),
          mainAxisExtent: ScreenDimensions.heightPercentage(context, 25),
          crossAxisCount: 2,
        ),
        itemCount: controller.product.length,
        itemBuilder: (context, index) {
          return DelayedDisplay(
            slidingBeginOffset: const Offset(-2, 0),
            delay: Duration(milliseconds: (index * 10) + 10),
            child: GestureDetector(
              onTap: () {
                if (!(StorageHandler().hasToken))
                {
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
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.offAll(const MainScreen(),
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
                                      child: Text(AppWord.later,
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
                }else{
                  Get.to( ProductDetails(productId: controller.product[index].id,),
                    duration: const Duration(milliseconds: 700),
                    transition: Transition.rightToLeft);
                }
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Positioned(
                    top: ScreenDimensions.heightPercentage(context, 5),
                    child: Directions(
                      child: Container(
                        width: ScreenDimensions.widthPercentage(context, 40),
                        height: ScreenDimensions.heightPercentage(context, 20),
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal:
                          ScreenDimensions.widthPercentage(context, 3),
                        ),
                        alignment: AlignmentDirectional.centerEnd,
                        decoration: BoxDecoration(
                            color: CustomColors.white1,
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(
                                  ScreenDimensions.widthPercentage(context, 2),
                                ),
                                topEnd: Radius.circular(
                                  ScreenDimensions.widthPercentage(context, 2),
                                )),
                            border: Border.all()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              controller.product[index].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppFonts.smallTitleFont(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: ScreenDimensions.heightPercentage(context, 1),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${AppWord.caliber} ${controller.product[index].carat}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFonts.smallTitleFont(context),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${AppWord.grams} ${controller.product[index].weight}',
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFonts.smallTitleFont(context),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.visibility_outlined),
                                Text(
                                  controller.product[index].views == null ||
                                      controller.product[index].views == 0
                                      ? '0'
                                      : controller.product[index].views.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFonts.smallTitleFont(context),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  alignment: AlignmentDirectional.centerEnd,
                                  width: ScreenDimensions.widthPercentage(context, 20),
                                  child: Text(
                                    '${AppWord.sad} ${controller.product[index].price.toInt()}',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: CustomColors.gold,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppFonts.smallTitleFont(context),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -ScreenDimensions.widthPercentage(context, 3),
                    top: ScreenDimensions.heightPercentage(context, 6),
                    child: Transform.rotate(
                      angle: 5.5,
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        color: CustomColors.red,
                        width: ScreenDimensions.widthPercentage(context, 17),
                        height: ScreenDimensions.heightPercentage(context, 1.5),
                        child: Text(
                          controller.getProductState(controller.product[index].productStatus),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: CustomColors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: ScreenDimensions.heightPercentage(context, 0),
                    child: AppNetworkImage(
                      baseUrlImages + controller.product[index].images.first['image'],
                      width: ScreenDimensions.widthPercentage(context, 20),
                      height: ScreenDimensions.heightPercentage(context, 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
