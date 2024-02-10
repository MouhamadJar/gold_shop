import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import '../controller/my_ads_filter_controller.dart';
import '../components/my_sells_filter_components.dart';

class MyAdsFilter extends GetView<MyAdsFilterController> {
  const MyAdsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyAdsFilterController());
    return SafeArea(
        child: Directions(
      child: Scaffold(
        backgroundColor: CustomColors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: CustomColors.white,
          title: Text(
            AppWord.myAdsFilter,
            style: TextStyle(
                fontSize: AppFonts.subTitleFont(context),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<MyAdsFilterController>(builder: (_) {
          return SizedBox(
            width: ScreenDimensions.screenWidth(context),
            height: ScreenDimensions.screenHeight(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: ScreenDimensions.widthPercentage(context, 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyAdsDropDownMenu(
                          title: controller.selectedCategory != null
                              ?controller.selectedCategory!['name']
                           :AppWord.productCategory,
                          items: controller.categories
                              .map((e) => PopupMenuItem(
                                    value: e,
                                    onTap: () {
                                      controller.getAllSubcategories(e['id']);
                                      controller.selectedCategory = e;
                                      controller.update();
                                    },
                                    child: Text(e['name']),
                                  ))
                              .toList(),
                          onSelected: (value) {}),
                      SizedBox(
                        width: ScreenDimensions.widthPercentage(context, 10),
                      ),
                      Text(
                        AppWord.productCategory,
                        style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                ),
                SizedBox(
                  width: ScreenDimensions.widthPercentage(context, 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyAdsDropDownMenu(
                          title: controller.selectedSubcategory != null
                              ? controller.selectedSubcategory!['name']
                              : AppWord.productClassification,
                          items: controller.subcategories
                              .map((e) => PopupMenuItem(
                                    child: Text(e['name']),
                                    value: e,
                                  ))
                              .toList(),
                          onSelected: (value) {
                            controller.selectedSubcategory = value;
                            controller.update();
                          }),
                      SizedBox(
                        width: ScreenDimensions.widthPercentage(context, 10),
                      ),
                      Text(
                        AppWord.productClassification,
                        style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                ),
                SizedBox(
                  width: ScreenDimensions.widthPercentage(context, 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: ScreenDimensions.widthPercentage(
                                    context, 40),
                                height: ScreenDimensions.heightPercentage(
                                    context, 3),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Directions(
                                  child: TextFormField(textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      controller.dateController1.clear();
                                      controller.dateController2.clear();

                                      if (int.parse(value) >
                                          int.parse(controller
                                              .priceController2.text)) {
                                        controller.priceController1.text =
                                            controller.priceController2.text;
                                      }
                                    },
                                    controller: controller.priceController1,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenDimensions.widthPercentage(
                                    context, 2),
                              ),
                              Text(
                                AppWord.from,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height:
                                ScreenDimensions.heightPercentage(context, 2),
                          ),
                          Row(
                            children: [
                              Container(
                                width: ScreenDimensions.widthPercentage(
                                    context, 40),
                                height: ScreenDimensions.heightPercentage(
                                    context, 3),
                                decoration: BoxDecoration(border: Border.all()),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    controller.dateController1.clear();
                                    controller.dateController2.clear();
                                    if (int.parse(value) <
                                        int.parse(
                                            controller.priceController1.text)) {
                                      controller.priceController2.text =
                                          controller.priceController1.text;
                                    }
                                  },
                                  controller: controller.priceController2,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                width: ScreenDimensions.widthPercentage(
                                    context, 2),
                              ),
                              Text(
                                AppWord.to,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppWord.price,
                            style: TextStyle(
                                fontSize: AppFonts.smallTitleFont(context),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                ),
                SizedBox(
                  width: ScreenDimensions.widthPercentage(context, 70),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: ScreenDimensions.widthPercentage(
                                    context, 40),
                                height: ScreenDimensions.heightPercentage(
                                    context, 3),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Directions(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      controller.priceController1.clear();
                                      controller.priceController2.clear();
                                    },
                                    controller: controller.dateController1,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'yyyy-mm-dd',
                                    ),
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenDimensions.widthPercentage(
                                    context, 2),
                              ),
                              Text(
                                AppWord.from,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height:
                                ScreenDimensions.heightPercentage(context, 2),
                          ),
                          Row(
                            children: [
                              Container(
                                width: ScreenDimensions.widthPercentage(
                                    context, 40),
                                height: ScreenDimensions.heightPercentage(
                                    context, 3),
                                decoration: BoxDecoration(border: Border.all()),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    controller.priceController1.clear();
                                    controller.priceController2.clear();
                                  },
                                  controller: controller.dateController2,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'yyyy-mm-dd',
                                  ),
                                  keyboardType: TextInputType.datetime,
                                ),
                              ),
                              SizedBox(
                                width: ScreenDimensions.widthPercentage(
                                    context, 2),
                              ),
                              Text(
                                AppWord.to,
                                style: TextStyle(
                                    fontSize: AppFonts.smallTitleFont(context),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppWord.postDate,
                            style: TextStyle(
                                fontSize: AppFonts.smallTitleFont(context),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                ),
                const Spacer(),
                Center(
                    child: AppButton(
                        text: Text(
                          AppWord.search,
                          style: TextStyle(
                            color: CustomColors.white,
                            fontSize: AppFonts.smallTitleFont(context),
                          ),
                        ),
                        onTap: controller.filter,
                        buttonBackground: AppImages.buttonLiteBackground))
              ],
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 3),
                horizontal: ScreenDimensions.widthPercentage(context, 3)),
          );
        }),
      ),
    ));
  }
}
