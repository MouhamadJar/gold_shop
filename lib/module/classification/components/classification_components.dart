// ignore_for_file: non_constant_identifier_names

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/category_products/view/category_products_view.dart';
import 'package:gold_shop/module/classification/controller/classification_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/utils/app_fonts.dart';

class ClassificationOfCategory extends GetView<ClassificationController> {
  const ClassificationOfCategory({super.key, required this.categoryId});

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    Get.put(ClassificationController());
    return GetBuilder<ClassificationController>(initState: (state) {
      controller.getSubcategories(categoryId: categoryId);
    }, builder: (_) {
      return GridView.builder(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: ScreenDimensions.widthPercentage(context, 5),
            vertical: ScreenDimensions.heightPercentage(context, 1)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: ScreenDimensions.widthPercentage(context, 7),
          mainAxisSpacing: ScreenDimensions.widthPercentage(context, 7),
          crossAxisCount: 3,
        ),
        itemCount: controller.subcategories.length,
        itemBuilder: (context, index) => DelayedDisplay(
          delay: Duration(milliseconds: (index * 10) + 10),
          child: GestureDetector(
            onTap: () {
              Get.to(
                  SubcategoryProducts(
                      subcategoryId: controller.subcategories[index].id,
                      pageTitle: controller.subcategories[index].name),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 700));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      ScreenDimensions.widthPercentage(context, 1)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 4),
                        color: CustomColors.shadow,
                        spreadRadius: 0.1,
                        blurRadius: 10,
                        blurStyle: BlurStyle.normal),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppNetworkImage(
                    baseUrlImages + controller.subcategories[index].image,
                    width: ScreenDimensions.widthPercentage(context, 10),
                    height: ScreenDimensions.heightPercentage(context, 5),
                  ),
                  Text(
                    controller.subcategories[index].name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context),
                        fontWeight: FontWeight.bold),
                  ).paddingSymmetric(
                      horizontal: ScreenDimensions.widthPercentage(context, 1)),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
