import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/product_payment_method/controller/product_payment_method_controller.dart';

class ProductPaymentMethod extends GetView<ProductPaymentMethodController> {
  const ProductPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductPaymentMethodController());
    return GetBuilder<ProductPaymentMethodController>(builder: (_) {
      return Directions(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: CustomColors.white,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: CustomColors.white,
              centerTitle: true,
              title: Text(
                AppWord.add,
                style: TextStyle(
                  fontSize: AppFonts.subTitleFont(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppWord.chooseDeliverMethod,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context) + 5,
                        fontWeight: FontWeight.bold),
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppWord.inPerson,
                        style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                      GetBuilder<ProductPaymentMethodController>(builder: (_) {
                        return Checkbox(
                          value: controller.inPerson,
                          onChanged: (value) {
                            controller.isChecked();
                            controller.inPerson = value!;
                          },
                          activeColor: CustomColors.gold,
                        );
                      })
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppWord.withMediatorShop,
                        style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                      GetBuilder<ProductPaymentMethodController>(builder: (_) {
                        return Checkbox(
                          value: controller.withMediatorShop,
                          onChanged: (value) {
                            controller.isChecked();
                            controller.withMediatorShop = value!;
                          },
                          activeColor: CustomColors.gold,
                        );
                      }),
                    ],
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                  controller.withMediatorShop == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppWord.chooseMediatorShop,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize:
                                      AppFonts.smallTitleFont(context) + 5,
                                  fontWeight: FontWeight.bold),
                            ).paddingSymmetric(
                                vertical: ScreenDimensions.heightPercentage(
                                    context, 2)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  AppWord.mediatorShopBetweenVendorAndBuyer,
                                  style: TextStyle(
                                      fontSize:
                                          AppFonts.smallTitleFont(context),
                                      fontWeight: FontWeight.bold),
                                ),
                                GetBuilder<ProductPaymentMethodController>(
                                    builder: (_) {
                                  return Checkbox(
                                    value: controller.mediatorShopBetween,
                                    onChanged: (value) {
                                      controller.withMediatorChecked();
                                      controller.mediatorShopBetween = value!;
                                    },
                                    activeColor: CustomColors.gold,
                                  );
                                })
                              ],
                            ).paddingSymmetric(
                                vertical: ScreenDimensions.heightPercentage(
                                    context, 2)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  AppWord.mediatorShopFromPlatform,
                                  style: TextStyle(
                                      fontSize:
                                          AppFonts.smallTitleFont(context),
                                      fontWeight: FontWeight.bold),
                                ),
                                GetBuilder<ProductPaymentMethodController>(
                                    builder: (_) {
                                  return Checkbox(
                                    value: controller.mediatorShopFromPlatform,
                                    onChanged: (value) {
                                      controller.withMediatorChecked();
                                      controller.mediatorShopFromPlatform =
                                          value!;
                                    },
                                    activeColor: CustomColors.gold,
                                  );
                                }),
                              ],
                            ).paddingSymmetric(
                                vertical: ScreenDimensions.heightPercentage(
                                    context, 2)),
                            Container(
                              padding: EdgeInsetsDirectional.all(
                                  ScreenDimensions.heightPercentage(
                                      context, 1)),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: CustomColors.shadow,
                                      spreadRadius: 0.1,
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 3)
                                ],
                                color: CustomColors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AppPopUpMenu(
                                          title: AppWord.chooseNeighborhood,
                                          items: [],
                                          onSelected: (value) {}),
                                      AppPopUpMenu(
                                          title: AppWord.chooseCity,
                                          items: [],
                                          onSelected: (value) {}),
                                    ],
                                  ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: ScreenDimensions.widthPercentage(
                                            context, 15),
                                        height:
                                            ScreenDimensions.heightPercentage(
                                                context, 4),
                                        child: AppButton(
                                            text: Text(
                                              AppWord.search,
                                              style: TextStyle(
                                                  color: CustomColors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onTap: () {},
                                            buttonBackground:
                                                AppImages.buttonLiteBackground),
                                      ),
                                      SizedBox(
                                        width: ScreenDimensions.widthPercentage(
                                            context, 20),
                                        height:
                                            ScreenDimensions.heightPercentage(
                                                context, 3),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          CustomColors.gold))),
                                        ),
                                      ),
                                      Text(
                                        AppWord.to,
                                        style: TextStyle(
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenDimensions.widthPercentage(
                                            context, 20),
                                        height:
                                            ScreenDimensions.heightPercentage(
                                                context, 3),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          CustomColors.gold))),
                                        ),
                                      ),
                                      Text(
                                        AppWord.from,
                                        style: TextStyle(
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
                                        ),
                                      ),
                                      Text(
                                        AppWord.platformProfit,
                                        style: TextStyle(
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
                                        ),
                                      ),
                                    ],
                                  ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                  SizedBox(
                                    width: ScreenDimensions.widthPercentage(
                                        context, 30),
                                    height: ScreenDimensions.heightPercentage(
                                        context, 4),
                                    child: TextFormField(
                                      textAlign: TextAlign.right,
                                      decoration: InputDecoration(
                                          hintText: AppWord
                                              .searchForMediatorShopName,
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: CustomColors.gold))),
                                    ),
                                  ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                  Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width:
                                              ScreenDimensions.widthPercentage(
                                                  context, 50),
                                          height:
                                              ScreenDimensions.heightPercentage(
                                                  context, 15),
                                          decoration: BoxDecoration(
                                              color: CustomColors.shadow,
                                              border: Border.all(
                                                  width: ScreenDimensions
                                                      .widthPercentage(
                                                          context, 1),
                                                  color: CustomColors.black)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppWord.mediatorShopName,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppFonts.smallTitleFont(
                                                                context) +
                                                            5,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          color: CustomColors
                                                              .yellow,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: AppFonts
                                                              .smallTitleFont(
                                                                  context)),
                                                      children: [
                                                    TextSpan(
                                                        text: AppWord
                                                            .checkingService),
                                                    const TextSpan(
                                                        text: ' 50 '),
                                                    TextSpan(
                                                        text: AppWord.sad),
                                                  ])),
                                              Text(
                                                'المدينة المنورة , حي النبلاء , شارع فارس الخوري',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppFonts.smallTitleFont(
                                                            context),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                ],
                              ),
                            ).paddingSymmetric(
                                vertical: ScreenDimensions.heightPercentage(
                                    context, 2)),
                          ],
                        ).paddingSymmetric(
                          vertical:
                              ScreenDimensions.heightPercentage(context, 2))
                      : const SizedBox.shrink(),
                  Text(
                    AppWord.backupPhone,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context) + 5,
                        fontWeight: FontWeight.bold),
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
                  const AppTextField(
                          title: '', keyboardType: TextInputType.phone)
                      .paddingSymmetric(
                          vertical:
                              ScreenDimensions.heightPercentage(context, 2)),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: ScreenDimensions.widthPercentage(context, 10),
                        height: ScreenDimensions.heightPercentage(context, 5),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: CustomColors.shadow,
                                spreadRadius: 0.1,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 3)
                          ],
                          color: CustomColors.gold,
                        ),
                        child: Icon(
                          Icons.add,
                          size: ScreenDimensions.widthPercentage(context, 7),
                          color: CustomColors.white,
                        ),
                      ),
                    ),
                  ).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 2),
                  ),
                  Text(
                    AppWord.thosePhoneNumbersWillBeHandled,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context),
                        fontWeight: FontWeight.bold),
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 10)),
                  controller.withMediatorShop==true?Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    TextButton(
                      onPressed: (){},
                      child: Text(
                      AppWord.privacyPolicy,
                      style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context),
                          fontWeight: FontWeight.bold),
                    ),),
                    Text(
                      AppWord.acceptTerms,
                      style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context),
                          fontWeight: FontWeight.bold),
                    ),
                      GetBuilder<ProductPaymentMethodController>(
                        builder: (_) {
                          return Checkbox(value: controller.privacyCheck, onChanged: (value){
                            controller.privacyIsChecked();
                            controller.privacyCheck= value!;
                          },activeColor: CustomColors.gold);
                        }
                      ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                  ],):SizedBox.shrink(),
                  Center(
                    child: AppButton(
                        text: Text(
                          AppWord.addThisProduct,
                          style: TextStyle(
                              color: CustomColors.white,
                              fontSize: AppFonts.smallTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {},
                        buttonBackground: AppImages.buttonLiteBackground),
                  ),
                ],
              ).paddingSymmetric(
                  horizontal: ScreenDimensions.widthPercentage(context, 4),
                  vertical: ScreenDimensions.heightPercentage(context, 2)),
            ),
          ),
        ),
      );
    });
  }
}
