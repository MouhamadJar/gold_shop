import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/components/components.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/utils/app_network_image.dart';
import '../components/category_products_components.dart';
import '../controller/category_products_controller.dart';
import '../../filter/view/filter_view.dart';
import '../../sort/view/sort_view.dart';
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
    return Directions(
      child: Scaffold(
        appBar: AppBar(
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
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const FilterScreen(),transition: Transition.fade,duration: const Duration(milliseconds: 700));
                      },
                      child: SvgPicture.asset(AppImages.filter,
                          height:
                              ScreenDimensions.heightPercentage(context, 3)),
                    ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 3)),
                    GestureDetector(
                      onTap: () {
                        Get.to(const SortScreen(),transition: Transition.fade,duration: const Duration(milliseconds: 700));
                      },
                      child: SvgPicture.asset(
                        AppImages.sort,
                        height: ScreenDimensions.heightPercentage(context, 3),
                      ),
                    ),
                    const Spacer(),
                    controller.isCityEmpty
                        ?const SizedBox.shrink()
                        :AppPopUpMenu(
                      title: controller.selectedCity,
                      items: controller.cities.map((element) => PopupMenuItem(
                        onTap: (){
                          controller.chooseCity(city: element.city, subcategoryId: subcategoryId);
                          controller.selectedCity = element.city;
                          controller.update();
                        },
                        value: element,
                        child: Text(
                            element.city,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),),),).toList(),

                    ),
                  ],
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            controller.subcategoriesADVS[index].paragraph,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: AppFonts.smallTitleFont(context)),
                          ),
                          AppNetworkImage(
                            baseUrlImages + controller.subcategoriesADVS[index].background,
                            fit: BoxFit.contain,
                            width: ScreenDimensions.widthPercentage(context, 25),
                            height: ScreenDimensions.heightPercentage(context, 5),
                          ),
                        ],
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
      ),
    );
  }
}
