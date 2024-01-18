// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/home/components/home_components.dart';
import 'package:gold_shop/module/home/controller/home_controller.dart';

import '../../../core/texts/words.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
        initState: (state){
         controller.getCity();
        },
        builder: (_) {
      return Column(
        children: [
          Directions(
            child: Container(
              alignment: AlignmentDirectional.centerEnd,
              width: ScreenDimensions.screenWidth(context),
              height: ScreenDimensions.heightPercentage(context, 9),
              margin: EdgeInsetsDirectional.symmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 5)),
              child:
              controller.isCityEmpty?const SizedBox.shrink():AppPopUpMenu(
                title: controller.selectedCity!,
                items: controller.cities.map((element) => PopupMenuItem(value: element,child: Text(element,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: AppFonts.smallTitleFont(context))),)).toList(),
                onSelected: (value) {
                  controller.selectedCity = value ;
                  controller.update();
                },
              ),
            ),
          ),
          AdvertisementBanner(items: [],),
          Directions(
            child: Container(
              width: ScreenDimensions.screenWidth(context),
              height: ScreenDimensions.heightPercentage(context, 8),
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 5)),
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                AppWord.categories,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppFonts.subTitleFont(context),
                ),
              ),
            ),
          ),
         const Expanded(
                  child: Category(),
                )
        ],
      );
    });
  }
}
