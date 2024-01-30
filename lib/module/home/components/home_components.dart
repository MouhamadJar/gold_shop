// ignore_for_file: non_constant_identifier_names

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/Classification/view/classification_view.dart';
import 'package:gold_shop/module/home/controller/home_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';

class Category extends GetView<HomeController> {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(initState: (state) {
      if (controller.categories.isEmpty) controller.getCategories();
    }, builder: (_) {
      return controller.isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: CustomColors.gold,
            ))
          : GridView.builder(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 5),
                  vertical: ScreenDimensions.heightPercentage(context, 2)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: ScreenDimensions.widthPercentage(context, 7),
                mainAxisSpacing: ScreenDimensions.widthPercentage(context, 7),
                crossAxisCount: 2,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) => DelayedDisplay(
                slidingBeginOffset: const Offset(-1, 0),
                delay: Duration(milliseconds: (index * 10) + 10),
                fadeIn: true,
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                        Classification(
                            categoryId: controller.categories[index].id,
                            pageTitle: controller.categories[index].name),
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
                            baseUrlImages + controller.categories[index].image,
                            width: ScreenDimensions.widthPercentage(context, 20)),
                        Text(
                          controller.categories[index].name,
                          style: TextStyle(
                              fontSize: AppFonts.subTitleFont(context),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
