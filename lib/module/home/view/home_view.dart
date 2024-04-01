// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/home/components/home_components.dart';
import 'package:gold_shop/module/home/controller/home_controller.dart';

import '../../../core/texts/words.dart';
import '../../../core/utils/app_network_image.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(builder: (_) {
      return Column(
        children: [
          // Directions(
          //   child: Container(
          //     alignment: AlignmentDirectional.centerEnd,
          //     width: ScreenDimensions.screenWidth(context),
          //     height: ScreenDimensions.heightPercentage(context, 9),
          //     margin: EdgeInsetsDirectional.symmetric(
          //         horizontal: ScreenDimensions.widthPercentage(context, 5)),
          //     child: controller.isCityEmpty
          //         ? const SizedBox.shrink()
          //         : AppPopUpMenu(
          //             title: controller.selectedCity!,
          //             items: controller.cities.map((element) => PopupMenuItem(
          //                       value: element,
          //                       child: Text(
          //                           element,
          //                           overflow: TextOverflow.ellipsis,
          //                           style: TextStyle(
          //                               fontSize:
          //                                   AppFonts.smallTitleFont(context))),
          //                     ))
          //                 .toList(),
          //             onSelected: (value) {
          //               controller.selectedCity = value;
          //               controller.update();
          //             },
          //           ),
          //   ),
          // ),
          controller.isBannerLoading
          ?  Center(child: CircularProgressIndicator(color: CustomColors.gold,))
              : controller.isBannerEmpty
              ? Container(
            width: ScreenDimensions.screenWidth(context),
            height: ScreenDimensions.heightPercentage(context, 15),
            decoration: BoxDecoration(gradient:  LinearGradient(
              stops: const [0, 1],
              colors: [
                CustomColors.black,
                CustomColors.greyDark,
              ],
            ),
            ),
            alignment: Alignment.center,
            child: Text(AppWord.noOffers,textAlign: TextAlign.center,style: TextStyle(fontSize: AppFonts.subTitleFont(context),color: CustomColors.white,fontWeight: FontWeight.bold)),
          )
              : AdvertisementBanner(
            itemBuilder: (context, index, realIndex) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppNetworkImage(
                    baseUrlImages + controller.ads[index].image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  child: Text(
                    controller.ads[index].paragraph,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: AppFonts.smallTitleFont(context)),
                  ),
                ),
              ],
            ),
            itemCount: controller.ads.length,
          ),
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
           Expanded(
            child: Category(categories: controller.categories,),
          )
        ],
      );
    });
  }
}
