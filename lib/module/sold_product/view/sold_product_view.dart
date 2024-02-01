import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/buy_order/view/buy_order_view.dart';
import 'package:gold_shop/module/sold_product/components/sold_product_components.dart';
import 'package:gold_shop/module/sold_product/contoller/sold_product_controller.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/images/images.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../core/utils/app_network_image.dart';

class SoldProduct extends GetView<SoldProductController> {
  const SoldProduct({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    Get.put(SoldProductController());
    return SafeArea(
      child: Directions(
        child: Scaffold(
          backgroundColor: CustomColors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppWord.productDetails,
              style: TextStyle(
                color: CustomColors.black,
                fontWeight: FontWeight.bold,
                fontSize: AppFonts.subTitleFont(context),
              ),
            ),
            elevation: 1,
            backgroundColor: CustomColors.white,
          ),
          body: GetBuilder<SoldProductController>(initState: (state) {
            controller.getProductDetails(productId: productId);
          }, builder: (_) {
            return controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.gold,
                    ),
                  )
                : SizedBox(
                    width: ScreenDimensions.screenWidth(context),
                    height: ScreenDimensions.screenHeight(context),
                    child: Column(
                      children: [
                        const PricesBar(),
                        SizedBox(
                          height: ScreenDimensions.heightPercentage(context, 3),
                        ),
                        controller.isBannersEmpty
                            ? const SizedBox.shrink()
                            : AdvertisementBanner(
                                itemBuilder: (context, index, realIndex) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: AppNetworkImage(
                                        baseUrlImages +
                                            controller
                                                .subcategoriesADVS[index].image,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller
                                            .subcategoriesADVS[index].paragraph,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: AppFonts.smallTitleFont(
                                                context)),
                                      ),
                                    ),
                                  ],
                                ),
                                itemCount: controller.subcategoriesADVS.length,
                              ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '${AppWord.productState} : ',
                                      style: TextStyle(
                                          fontSize:
                                              AppFonts.subTitleFont(context),
                                          color: CustomColors.yellow,
                                          shadows: [
                                            Shadow(
                                                blurRadius: 3,
                                                color: CustomColors.shadow),
                                          ])),
                                  TextSpan(
                                      text: AppWord.sold,
                                      style: TextStyle(
                                          fontSize:
                                              AppFonts.subTitleFont(context),
                                          color: CustomColors.yellow,
                                          shadows: [
                                            Shadow(
                                                blurRadius: 3,
                                                color: CustomColors.shadow),
                                          ])),
                                ])),
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      InteractiveViewer(
                                        child: AppNetworkImage(baseUrlImages +
                                            controller.model!.images[0]
                                                ['image']),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsetsDirectional.symmetric(
                                      vertical: ScreenDimensions.heightPercentage(context, 2),
                                    ),
                                    width: ScreenDimensions.screenWidth(context),
                                    height: ScreenDimensions.heightPercentage(context, 25),
                                    child: AppNetworkImage (baseUrlImages + controller.model!.images[0]['image']),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenDimensions.heightPercentage(context, 10),
                                  child:  ProductImages(image: controller.model!.images,
                                    itemCount: controller.model!.images.length,
                                  ),
                                ),
                                Directions(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${controller.model!.code}',
                                            style: TextStyle(
                                              fontSize: AppFonts.subTitleFont(
                                                  context),
                                              color: CustomColors.black,
                                            ),
                                          ),
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                TextSpan(
                                                  text:
                                                      '${AppWord.productName} ',
                                                ),
                                                TextSpan(
                                                  text: '${AppWord.caliber} ',
                                                ),
                                                TextSpan(
                                                  text: controller.model!.carat.toString(),
                                                ),
                                              ],
                                                  style: TextStyle(
                                                      color: CustomColors.black,
                                                      fontSize:
                                                          AppFonts.subTitleFont(
                                                              context)))),
                                        ],
                                      ),
                                      Text(
                                        controller.model!.description,
                                        style: TextStyle(
                                            fontSize: AppFonts.smallTitleFont(
                                                context)),
                                      ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                      Text(
                                        AppWord.productDetails,
                                        style: TextStyle(
                                            fontSize:
                                                AppFonts.subTitleFont(context),
                                            color: CustomColors.yellow,
                                            shadows: [
                                              Shadow(
                                                  blurRadius: 3,
                                                  color: CustomColors.shadow),
                                            ]),
                                      ),
                                      Details(
                                          withIcon: true,
                                          details: controller.model!.manufacturer!.toString(),
                                          title: AppWord.manufacturer,
                                          picPath: AppImages.building),
                                      Details(
                                          withIcon: true,
                                          details: controller.model!.age.toString(),
                                          title: AppWord.age,
                                          picPath: AppImages.age),
                                      Details(
                                          withIcon: true,
                                          details: controller.model!.weight.toString(),
                                          title: AppWord.weight,
                                          picPath: AppImages.weightScale),
                                      Details(
                                          withIcon: true,
                                          details: controller.model!.currentGoldPrice.toString(),
                                          title: AppWord.gramPrice,
                                          picPath: AppImages.priceTag),
                                      Details(
                                          withIcon: true,
                                          details: controller.model!.price.toString(),
                                          title: AppWord.productPrice,
                                          picPath: AppImages.priceTag),
                                      Details(
                                          withIcon: true,
                                          details: controller. model!.carat.toString(),
                                          title: AppWord.productCalibre,
                                          picPath: AppImages.scale),
                                    ],
                                  ),
                                ).paddingSymmetric(
                                    horizontal:
                                        ScreenDimensions.widthPercentage(
                                            context, 5)),
                                Directions(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        AppWord.purchaseProcessInfo,
                                        style: TextStyle(
                                            fontSize:
                                                AppFonts.subTitleFont(context),
                                            color: CustomColors.yellow,
                                            shadows: [
                                              Shadow(
                                                  blurRadius: 3,
                                                  color: CustomColors.shadow),
                                            ]),
                                      ),
                                      SoldProcessDetails(
                                          title: AppWord.amountPaid,
                                          subtitle: AppWord.sad,
                                          amount: (controller.model!.price + controller.model!.profit+controller.model!.currentGoldPrice).toString()),
                                      SoldProcessDetails(
                                          title: AppWord.productPrice,
                                          subtitle: AppWord.sad,
                                          amount: controller.model!.price.toString()),
                                      SoldProcessDetails(
                                          title: AppWord.gramPrice,
                                          subtitle: AppWord.sad,
                                          amount: controller.model!.currentGoldPrice.toString()),
                                      SoldProcessDetails(
                                          title: AppWord.appServiceCost,
                                          subtitle: AppWord.sad,
                                          amount: controller.model!.profit.toString()),
                                      SoldProcessDetails(
                                        title: AppWord.buyerName,
                                        subtitle: '${controller.model!.firstName} ${controller.model!.lastName}',
                                      ),
                                      SoldProcessDetails(
                                        title: AppWord.buyerNumber,
                                        subtitle: controller.model!.phoneNumber,
                                      ),
                                    ],
                                  ).paddingSymmetric(
                                      vertical: ScreenDimensions.heightPercentage(context, 2),
                                      horizontal: ScreenDimensions.widthPercentage(context, 5)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'السعودية, المدينة المنورة , حي النبلاء',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              AppFonts.smallTitleFont(context)),
                                    ),
                                    SizedBox(
                                      width: ScreenDimensions.widthPercentage(
                                          context, 1),
                                    ),
                                    SvgPicture.asset(
                                      AppImages.location,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: ScreenDimensions.screenWidth(context),
                                  height: ScreenDimensions.heightPercentage(
                                      context, 15),
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                ).paddingSymmetric(
                                    vertical: ScreenDimensions.heightPercentage(context, 2)),
                                Directions(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FloatingContainer(
                                        title: AppWord.rate,
                                        picPath: AppImages.star,
                                        onTap: () {
                                          Get.dialog(
                                            Directions(
                                              child: Material(
                                                color: Colors.transparent,
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaY: 10, sigmaX: 10),
                                                  child: Container(
                                                    margin: EdgeInsetsDirectional.only(
                                                        top: ScreenDimensions.heightPercentage(
                                                            context, 5),
                                                        bottom: ScreenDimensions
                                                            .heightPercentage(
                                                                context, 40),
                                                        start: ScreenDimensions
                                                            .widthPercentage(
                                                                context, 5),
                                                        end: ScreenDimensions
                                                            .widthPercentage(
                                                                context, 5)),
                                                    padding: EdgeInsetsDirectional.all(ScreenDimensions.widthPercentage(context, 3)),
                                                    color: CustomColors.white,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                child: SvgPicture.asset(
                                                                    AppImages.x,
                                                                    width: ScreenDimensions
                                                                        .widthPercentage(
                                                                            context,
                                                                            3))),
                                                          ],
                                                        ),
                                                        RateField(
                                                          controller: controller.buyerMessageController,
                                                          onRatingUpdate: (starsNumber){
                                                            controller.buyerStars = starsNumber.toInt();
                                                          },
                                                            title: AppWord.rateBuyer),
                                                        RateField(
                                                            onRatingUpdate: (starsNumber){},
                                                            title: AppWord.rateProduct),
                                                        RateField(
                                                          controller: controller.serviceMessageController,
                                                            onRatingUpdate: (starsNumber){
                                                            controller.serviceStars = starsNumber.toInt();
                                                            },
                                                            title: AppWord.rateService),
                                                        Center(
                                                            child: AppButton(
                                                                text: Text(
                                                                  AppWord.send,
                                                                  style: TextStyle(color: CustomColors.white,
                                                                      fontSize: AppFonts.smallTitleFont(context)),
                                                                ),
                                                                onTap: () {
                                                                  controller.rateForSeller(productId: controller.model!.id);
                                                                },
                                                                buttonBackground: AppImages.buttonLiteBackground))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      FloatingContainer(
                                        title: AppWord.shareProduct,
                                        picPath: AppImages.share,
                                        onTap: () {
                                          Get.dialog(
                                            Directions(
                                              child: Material(
                                                color: Colors.transparent,
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaY: 10, sigmaX: 10),
                                                  child: Container(
                                                    margin: EdgeInsetsDirectional.only(
                                                        top: ScreenDimensions.heightPercentage(
                                                            context, 5),
                                                        bottom: ScreenDimensions
                                                            .heightPercentage(
                                                                context, 70),
                                                        start: ScreenDimensions
                                                            .widthPercentage(
                                                                context, 5),
                                                        end: ScreenDimensions
                                                            .widthPercentage(
                                                                context, 5)),
                                                    padding: EdgeInsetsDirectional
                                                        .all(ScreenDimensions
                                                            .widthPercentage(
                                                                context, 3)),
                                                    color: CustomColors.white,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                child: SvgPicture.asset(
                                                                    AppImages.x,
                                                                    width: ScreenDimensions
                                                                        .widthPercentage(
                                                                            context,
                                                                            3))),
                                                            Text(
                                                                AppWord
                                                                    .shareProductOnWhatsapp,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: AppFonts
                                                                        .smallTitleFont(
                                                                            context))),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                                padding: EdgeInsetsDirectional.all(
                                                                    ScreenDimensions
                                                                        .widthPercentage(
                                                                            context,
                                                                            4)),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        boxShadow: [
                                                                      BoxShadow(
                                                                          blurRadius:
                                                                              5,
                                                                          color: CustomColors
                                                                              .shadow,
                                                                          blurStyle: BlurStyle
                                                                              .outer,
                                                                          spreadRadius:
                                                                              1)
                                                                    ]),
                                                                child: SvgPicture
                                                                    .asset(AppImages
                                                                        .whatsApp)),
                                                          ],
                                                        ).paddingSymmetric(
                                                            vertical:
                                                                ScreenDimensions
                                                                    .heightPercentage(
                                                                        context,
                                                                        5)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      FloatingContainer(
                                        title: AppWord.reportProblem,
                                        picPath: AppImages.report,
                                        onTap: () {
                                          Get.dialog(
                                            Directions(
                                              child: Material(
                                                color: Colors.transparent,
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaY: 10, sigmaX: 10),
                                                  child: Container(
                                                    margin: EdgeInsetsDirectional.only(
                                                        top: ScreenDimensions.heightPercentage(
                                                            context, 5),
                                                        bottom: ScreenDimensions
                                                            .heightPercentage(
                                                                context, 45),
                                                        start: ScreenDimensions
                                                            .widthPercentage(
                                                                context, 5),
                                                        end: ScreenDimensions
                                                            .widthPercentage(
                                                                context, 5)),
                                                    padding: EdgeInsetsDirectional
                                                        .all(ScreenDimensions
                                                            .widthPercentage(
                                                                context, 3)),
                                                    color: CustomColors.white,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                child: SvgPicture.asset(
                                                                    AppImages.x,
                                                                    width: ScreenDimensions
                                                                        .widthPercentage(
                                                                            context,
                                                                            3))),
                                                            Text(
                                                                AppWord
                                                                    .reportProblem,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: AppFonts
                                                                        .smallTitleFont(
                                                                            context))),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            AppPopUpMenu(
                                                                title: '',
                                                                items: [],
                                                                onSelected:
                                                                    (value) {}),
                                                            Text(
                                                              AppWord
                                                                  .defineProblem,
                                                              style: TextStyle(
                                                                fontSize: AppFonts
                                                                    .smallTitleFont(
                                                                        context),
                                                              ),
                                                            ),
                                                          ],
                                                        ).paddingSymmetric(
                                                          vertical: ScreenDimensions
                                                              .heightPercentage(
                                                                  context, 4),
                                                        ),
                                                        Text(
                                                          AppWord
                                                              .describeProblem,
                                                          style: TextStyle(
                                                              fontSize: AppFonts
                                                                  .smallTitleFont(
                                                                      context)),
                                                        ).paddingOnly(
                                                            left: ScreenDimensions
                                                                .widthPercentage(
                                                                    context,
                                                                    60)),
                                                        Container(
                                                          height: ScreenDimensions
                                                              .heightPercentage(
                                                                  context, 15),
                                                          margin: EdgeInsetsDirectional.symmetric(
                                                              horizontal:
                                                                  ScreenDimensions
                                                                      .widthPercentage(
                                                                          context,
                                                                          8)),
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all()),
                                                          child: TextFormField(
                                                            maxLines: 5,
                                                            decoration:
                                                                const InputDecoration(
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ).paddingSymmetric(
                                                              horizontal:
                                                                  ScreenDimensions
                                                                      .widthPercentage(
                                                                          context,
                                                                          7)),
                                                        ).paddingSymmetric(
                                                            vertical:
                                                                ScreenDimensions
                                                                    .heightPercentage(
                                                                        context,
                                                                        2)),
                                                        AppButton(
                                                                text: Text(
                                                                  AppWord.send,
                                                                  style: TextStyle(
                                                                      color: CustomColors
                                                                          .white,
                                                                      fontSize:
                                                                          AppFonts.smallTitleFont(
                                                                              context),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                buttonBackground:
                                                                    AppImages
                                                                        .buttonLiteBackground)
                                                            .paddingSymmetric(
                                                                vertical: ScreenDimensions
                                                                    .heightPercentage(
                                                                        context,
                                                                        1)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ).paddingSymmetric(
                                      vertical:
                                          ScreenDimensions.widthPercentage(
                                              context, 2)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      width: ScreenDimensions.widthPercentage(context, 30),
                                      height: ScreenDimensions.heightPercentage(context, 5),
                                      color: CustomColors.gold,
                                      child: Text(
                                        AppWord.shopReport,
                                        style: TextStyle(
                                            color: CustomColors.white,
                                            fontSize: AppFonts.smallTitleFont(context),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(const BuyOrder(),
                                            transition: Transition.fadeIn,
                                            duration: const Duration(
                                                milliseconds: 500));
                                      },
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        width: ScreenDimensions.widthPercentage(
                                            context, 30),
                                        height:
                                            ScreenDimensions.heightPercentage(
                                                context, 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: CustomColors.gold)),
                                        child: Text(
                                          AppWord.buyOrder,
                                          style: TextStyle(
                                              color: CustomColors.gold,
                                              fontSize: AppFonts.smallTitleFont(
                                                  context),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(
                                    vertical: ScreenDimensions.heightPercentage(
                                        context, 2)),
                                AppButton(
                                  onTap: () {},
                                  text: Text(
                                    AppWord.downloadPDFFile,
                                    style: TextStyle(
                                      color: CustomColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          AppFonts.smallTitleFont(context),
                                    ),
                                  ),
                                  buttonBackground:
                                      AppImages.buttonDarkBackground,
                                ).paddingSymmetric(
                                    vertical: ScreenDimensions.heightPercentage(
                                        context, 1)),
                                AppButton(
                                  onTap: () {},
                                  text: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppWord.editProductInfo,
                                        style: TextStyle(
                                          color: CustomColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              AppFonts.smallTitleFont(context),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenDimensions.widthPercentage(
                                            context, 2),
                                      ),
                                      SvgPicture.asset(AppImages.edit),
                                    ],
                                  ),
                                  buttonBackground:
                                      AppImages.buttonLiteBackground,
                                ).paddingSymmetric(
                                    vertical: ScreenDimensions.heightPercentage(
                                        context, 1)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
