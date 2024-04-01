import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/module/Classification/components/classification_components.dart';
import 'package:gold_shop/module/classification/controller/classification_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';

class Classification extends GetView<ClassificationController> {
  const Classification({super.key,required this.pageTitle, required this.categoryId});

  final int categoryId;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    Get.put(ClassificationController());
    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.all(
                ScreenDimensions.widthPercentage(context, 2)),
            child: SvgPicture.asset(
              AppImages.saudiArabia,
              height: ScreenDimensions.heightPercentage(context, 5),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          pageTitle,
          style: TextStyle(
            color: CustomColors.black,
            fontWeight: FontWeight.bold,
            fontSize: AppFonts.subTitleFont(context),
          ),
        ),
        leading: const BackArrow(),
        elevation: 1,
        backgroundColor: CustomColors.white,
      ),
      body: GetBuilder<ClassificationController>(
          initState: (state) {
        controller.getSubcategories(categoryId: categoryId);
        controller.categoryADVS(categoryId: categoryId);
        // controller.getCity();
      }, builder: (_) {
        return Column(
          children: [
            const PricesBar(),
            // Directions(
            //   child: Container(
            //       alignment: AlignmentDirectional.centerEnd,
            //       width: ScreenDimensions.screenWidth(context),
            //       height: ScreenDimensions.heightPercentage(context, 9),
            //       margin: EdgeInsetsDirectional.symmetric(
            //           horizontal: ScreenDimensions.widthPercentage(context, 5)),
            //       child: controller.isCityEmpty?const SizedBox.shrink():AppPopUpMenu(
            //         title: controller.selectedCity!,
            //         items: controller.cities.map((element) => PopupMenuItem(value: element,child: Text(element,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: AppFonts.smallTitleFont(context))),)).toList(),
            //         onSelected: (value) {
            //           controller.selectedCity = value ;
            //           controller.update();
            //         },
            //
            //       ),
            //   ),
            // ),
            controller.isBannersEmpty
                ? const SizedBox.shrink()
                : AdvertisementBanner(
              itemBuilder: (context, index, realIndex) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppNetworkImage(
                      baseUrlImages + controller.categoriesADVS[index].image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      controller.categoriesADVS[index].paragraph,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: AppFonts.smallTitleFont(context)),
                    ),
                  ),
                ],
              ),
              itemCount: controller.categoriesADVS.length,
            ),
            Directions(
              child: Container(
                width: ScreenDimensions.screenWidth(context),
                height: ScreenDimensions.heightPercentage(context, 8),
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 5)),
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  AppWord.classification,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFonts.subTitleFont(context),
                  ),
                ),
              ),
            ),
            controller.isLoading
                ? Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                      color: CustomColors.gold,
                    )),
                )
                : controller.isSubcategoryEmpty
                    ? Expanded(
                      child: Center(
                          child: Text(
                            AppWord.nothingToShow,
                            style: TextStyle(
                                fontSize: AppFonts.subTitleFont(context),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    )
                    : Expanded(
                        child: ClassificationOfCategory(categoryId: categoryId),
                      ),
          ],
        );
      }),
    ));
  }
}
