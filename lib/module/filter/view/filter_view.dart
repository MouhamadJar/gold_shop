import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/filter/controller/filter_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';

class FilterScreen extends GetView<FilterController> {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FilterController());
    return GetBuilder<FilterController>(builder: (_) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.white,
          appBar: AppBar(
            backgroundColor: CustomColors.white,
            centerTitle: true,
            elevation: 1,
            leading: const BackArrow(),
            title: Text(
              AppWord.filterProducts,
              style: TextStyle(
                fontSize: AppFonts.subTitleFont(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: controller.isLoading? Center(child: CircularProgressIndicator(color: CustomColors.gold,)):SizedBox(
            height: ScreenDimensions.screenHeight(context),
            width: ScreenDimensions.screenWidth(context),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppWord.productCalibre,
                        style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context),
                        ),
                      ),
                      AppPopUpMenu(
                        title: controller.title,
                        items: controller.carats.map((e) => PopupMenuItem(child: Text(e,style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),),
                          onTap: (){
                          controller.title= e;
                          controller.carat = controller.title;
                          controller.update();
                           },)).toList(),
                      ).paddingSymmetric(
                          horizontal:
                              ScreenDimensions.widthPercentage(context, 10)),
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                    child: Row(
                      children: [
                        Text(
                          AppWord.productType,
                          style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                          ),
                        ),
                        AppPopUpMenu(
                          title: controller.selectedProductType,
                          items: controller.productTypes.map((e) => PopupMenuItem(child: Text(e,style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),),
                            onTap: (){
                            controller.selectedProductType= e;
                            if(controller.selectedProductType == AppWord.news){
                              controller.productType = 1;
                              controller.update();
                            }
                            if(controller.selectedProductType == AppWord.likeNew){
                              controller.productType = 3;
                              controller.update();
                            }
                            if(controller.selectedProductType == AppWord.used){
                              controller.productType = 2;
                              controller.update();
                            }
                            controller.update();
                             },)).toList(),
                        ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 12)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: controller.priceCheck,
                              onChanged: (value) {
                                controller.priceCheck = value!;
                                controller.weightCheck = false;
                                controller.priceCheck?controller.byPrice=1:controller.byPrice=0;
                                controller.byWeight = 0;
                                controller.update();
                              },
                              activeColor: CustomColors.gold),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: CustomColors.black,
                                  fontSize: AppFonts.smallTitleFont(context)),
                              children: [
                                TextSpan(text: '${AppWord.filter} '),
                                TextSpan(text: AppWord.price),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.weightCheck,
                              onChanged: (value) {
                                controller.weightCheck = value!;
                                controller.priceCheck = false;
                                controller.weightCheck?controller.byWeight=1:controller.byWeight=0;
                                controller.byPrice = 0;
                                controller.update();
                              },
                              activeColor: CustomColors.gold),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: CustomColors.black,
                                  fontSize: AppFonts.smallTitleFont(context)),
                              children: [
                                TextSpan(text: '${AppWord.filter} '),
                                TextSpan(text: AppWord.weights),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: CustomColors.black,
                              fontSize: AppFonts.smallTitleFont(context)),
                          children: [
                            TextSpan(text: '${AppWord.price} \t'),
                            TextSpan(text: AppWord.from),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: ScreenDimensions.widthPercentage(context, 30),
                        child: TextFormField(
                          validator: (value) {
                            if (controller.priceCheck) {
                              if (value!.isEmpty) {
                                return AppWord.empty;
                              }
                            }
                          },
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          enabled: controller.priceCheck,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: CustomColors.gold))),
                          keyboardType: TextInputType.number,
                          controller: controller.fromPriceController,
                          onChanged: (val) {
                            if (int.parse(val) >
                                int.parse(controller.toPriceController.text)) {
                              controller.fromPriceController.text =
                                  controller.toPriceController.text;
                            }
                          },
                        ),
                      ),
                      Text(
                        AppWord.to,
                        style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context),
                        ),
                      ),
                      SizedBox(
                        width: ScreenDimensions.widthPercentage(context, 30),
                        child: TextFormField(
                          validator: (value) {
                            if (controller.priceCheck) {
                              if (value!.isEmpty) {
                                return AppWord.empty;
                              }
                            }
                          },
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          enabled: controller.priceCheck,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: CustomColors.gold))),
                          keyboardType: TextInputType.number,
                          controller: controller.toPriceController,
                          onChanged: (_) {
                            // if(int.parse(controller1.text) > int.parse(controller2.text) ){}
                            // controller1.text = controller2.text;
                          },
                        ),
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: CustomColors.black,
                              fontSize: AppFonts.smallTitleFont(context)),
                          children: [
                            TextSpan(text: '${AppWord.weights} \t'),
                            TextSpan(text: AppWord.from),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: ScreenDimensions.widthPercentage(context, 30),
                        child: TextFormField(
                          validator: (value) {
                            if (controller.weightCheck) {
                              if (value!.isEmpty) {
                                return AppWord.empty;
                              }
                            }
                          },
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          enabled: controller.weightCheck,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: CustomColors.gold))),
                          keyboardType: TextInputType.number,
                          controller: controller.fromWeightController,
                          onChanged: (val) {
                            if (int.parse(val) >
                                int.parse(controller.toWeightController.text)) {
                              controller.fromWeightController.text =
                                  controller.toWeightController.text;
                            }
                          },
                        ),
                      ),
                      Text(
                        AppWord.to,
                        style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context),
                        ),
                      ),
                      SizedBox(
                        width: ScreenDimensions.widthPercentage(context, 30),
                        child: TextFormField(
                          validator: (value) {
                            if (controller.weightCheck) {
                              if (value!.isEmpty) {
                                return AppWord.empty;
                              }
                            }
                          },
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          enabled: controller.weightCheck,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: CustomColors.gold))),
                          keyboardType: TextInputType.number,
                          controller: controller.toWeightController,
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                  const Spacer(),
                  AppButton(
                          text: Text(
                            AppWord.search,
                            style: TextStyle(
                                color: CustomColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.smallTitleFont(context)),
                          ),
                          onTap: () {
                            if(controller.weightCheck==false&&controller.priceCheck==false){
                              ControllerSnackBar(errorMessage: AppWord.choosePriceOrWeight);
                            }
                            if(controller.priceCheck){
                              if(controller.fromPriceController.text.isEmpty||controller.toPriceController.text.isEmpty){
                                ControllerSnackBar(errorMessage: AppWord.pricesShouldNotBeEmpty);
                                if (!(controller.formKey.currentState!.validate())) {
                                  return;
                                }
                              }
                            }
                            if(controller.weightCheck){
                              if(controller.fromWeightController.text.isEmpty||controller.toWeightController.text.isEmpty){
                                ControllerSnackBar(errorMessage: AppWord.weightsShouldNotBeEmpty);
                                if (!(controller.formKey.currentState!.validate())) {
                                  return;
                                }
                              }
                            }
                            if(controller.productType == null){
                              ControllerSnackBar(errorMessage: AppWord.productTypeIsRequired);
                            }
                            if(controller.carat == null){
                              ControllerSnackBar(errorMessage: AppWord.caliberIsRequired);
                            }
                            else{controller.filterProducts();}
                          },
                          buttonBackground: AppImages.buttonLiteBackground),

                ],
              ).paddingSymmetric(
                  vertical: ScreenDimensions.heightPercentage(context, 3),
                  horizontal: ScreenDimensions.widthPercentage(context, 3)),
            ),
          ),
        ),
      );
    });
  }
}
