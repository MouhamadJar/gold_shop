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
            leading: const SizedBox.shrink(),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_forward,
                  size: ScreenDimensions.widthPercentage(context, 6),
                ),
              )
            ],
            title: Text(
              AppWord.filterProducts,
              style: TextStyle(
                fontSize: AppFonts.subTitleFont(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SizedBox(
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
                        onSelected: (value) {
                          controller.value = value;
                          controller.pupUpText();
                        },
                        title: controller.title,
                        items: [
                          PopupMenuItem(
                            value: 0,
                            child: Text('${AppWord.caliber} \t 24'),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Text('${AppWord.caliber} \t 22'),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text('${AppWord.caliber} \t 21'),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: Text('${AppWord.caliber} \t 18'),
                          ),
                        ],
                      ).paddingSymmetric(
                          horizontal:
                              ScreenDimensions.widthPercentage(context, 10)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: controller.checked,
                              onChanged: (value) {
                                controller.checkValue();
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
                              value: !controller.checked,
                              onChanged: (value) {
                                controller.uncheckValue();
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
                            if (controller.checked) {
                              if (value!.isEmpty) {
                                return AppWord.empty;
                              } else {
                                return '';
                              }
                            } else {}
                          },
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          enabled: controller.checked,
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
                            if (controller.checked) {
                              if (value!.isEmpty) {
                                return AppWord.empty;
                              } else {
                                return '';
                              }
                            } else {}
                          },
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          enabled: controller.checked,
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
                            if (!controller.checked) {
                              if (value!.isEmpty) {
                                return AppWord.empty;
                              } else {
                                return '';
                              }
                            } else {}
                          },
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          enabled: !controller.checked,
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
                            if (!controller.checked) {
                              if (value!.isEmpty) {
                                return AppWord.empty;
                              } else {
                                return '';
                              }
                            } else {}
                          },
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          enabled: !controller.checked,
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
                        print(controller.fromWeightController.text);
                        print(controller.toWeightController.text);
                        controller.caratNotNull();
                        if (controller.formKey.currentState!.validate()) {}
                        if (controller.checked == false) {
                          controller.weightFilter();
                        } else {
                          controller.priceFilter();
                        }
                      },
                      buttonBackground: AppImages.buttonLiteBackground)
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
