// ignore_for_file: non_constant_identifier_names

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/Classification/view/classification_view.dart';
import 'package:gold_shop/module/categories/controller/categories_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';

class Category extends GetView<CategoriesController> {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesController());
    return GetBuilder<CategoriesController>(initState: (state) {
      controller.getCategories();
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
                crossAxisSpacing: ScreenDimensions.widthPercentage(context, 15),
                mainAxisSpacing: ScreenDimensions.widthPercentage(context, 15),
                crossAxisCount: 2,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) => DelayedDisplay(
                slidingBeginOffset: const Offset(0, 3),
                delay: Duration(milliseconds: (index * 10) + 10),
                child: GestureDetector(
                  onTap: () {
                    Get.to( Classification(categoryId: controller.categories[index].id,pageTitle: controller.categories[index].name),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            ScreenDimensions.widthPercentage(context, 1)),
                        border: Border.all(
                            width: ScreenDimensions.widthPercentage(
                                context, 0.6))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppNetworkImage(controller.categories[index].image,width: ScreenDimensions.widthPercentage(context, 20)),
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
