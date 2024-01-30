import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/module/category_products/components/category_products_components.dart';
import 'package:gold_shop/module/category_products/controller/category_products_controller.dart';
import 'package:gold_shop/module/filter/view/filter_view.dart';
import 'package:gold_shop/module/sort/view/sort_view.dart';

import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';

class SubcategoryProducts extends GetView<SubcategoryProductsController> {
  const SubcategoryProducts({super.key, required this.subcategoryId,required this.pageTitle});

  final int subcategoryId;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    Get.put(SubcategoryProductsController());
    return Scaffold(
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
      body: GetBuilder<SubcategoryProductsController>(initState: (state) {
        controller.getAllProducts(subcategoryId: subcategoryId);
        controller.product.clear();
        controller.subcategoriesADVS.clear();
        controller.subcategoryADVS(subcategoryId: subcategoryId);
        controller.getCity();
      }, builder: (_) {
        return Column(
          children: [
            const PricesBar(),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              width: ScreenDimensions.screenWidth(context),
              height: ScreenDimensions.heightPercentage(context, 6),
              margin: EdgeInsetsDirectional.symmetric(
                horizontal: ScreenDimensions.widthPercentage(context, 5),
              ),
              child: Directions(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const FilterScreen());
                      },
                      child: SvgPicture.asset(AppImages.filter,
                          height:
                              ScreenDimensions.heightPercentage(context, 3)),
                    ),
                    SizedBox(
                      width: ScreenDimensions.widthPercentage(context, 3),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(const SortScreen());
                      },
                      child: SvgPicture.asset(
                        AppImages.sort,
                        height: ScreenDimensions.heightPercentage(context, 3),
                      ),
                    ),
                    const Spacer(),
                    controller.isCityEmpty?const SizedBox.shrink():AppPopUpMenu(
                      title: controller.selectedCity!,
                      items: controller.cities.map((element) => PopupMenuItem(value: element,child: Text(element,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: AppFonts.smallTitleFont(context))),)).toList(),
                      onSelected: (value) {
                        controller.selectedCity = value ;
                        controller.chooseCity(subcategoryId: 1, city: value,);
                        controller.update();
                      },

                    ),
                  ],
                ),
              ),
            ),
            controller.isBannersEmpty
                ? const SizedBox.shrink()
                : AdvertisementBanner(
              itemBuilder: (context, index, realIndex) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppNetworkImage(
                      baseUrlImages + controller.subcategoriesADVS[index].image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      controller.subcategoriesADVS[index].paragraph,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: AppFonts.smallTitleFont(context)),
                    ),
                  ),
                ],
              ),
              itemCount: controller.subcategoriesADVS.length,
            ),
            controller.isLoading
                ? Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                        color: CustomColors.gold,
                      ),
                    ),
                )
                : controller.isSubcategoryEmpty
                  ? Expanded(
                      child: Center(
                          child: Text(
                            AppWord.nothingToShow,
                            style: TextStyle(
                              color: CustomColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.subTitleFont(context)),
                          ),
                        ),
                    )
                  : Expanded(
                        child: ProductsCard(
                          subcategoryId: subcategoryId,
                        ),
                      )
          ],
        );
      }),
    );
  }
}
