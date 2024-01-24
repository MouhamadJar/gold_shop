import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/module/invoice/view/invoice_view.dart';
import 'package:gold_shop/module/product_details/controller/product_details_controller.dart';
import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';

class ProductDetails extends GetView<ProductDetailsController> {
  const ProductDetails({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsController());
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
            AppWord.productDetails,
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
        body: GetBuilder<ProductDetailsController>(initState: (state) {
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
                      const PricesBar().paddingOnly(bottom: ScreenDimensions.heightPercentage(context, 3)),
                      controller.isBannersEmpty
                          ? const SizedBox.shrink()
                          : AdvertisementBanner(
                              items: [
                                ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.subcategoriesADVS.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return SizedBox(
                                      width: ScreenDimensions.screenWidth(context),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: AppNetworkImage(
                                                  controller.subcategoriesADVS[index].image,
                                                  fit: BoxFit.fitHeight)),
                                          Expanded(
                                              child: Text(
                                                  controller.subcategoriesADVS[index].paragraph,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: AppFonts
                                                          .smallTitleFont(
                                                              context))))
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(InteractiveViewer(
                                      child: AppNetworkImage(
                                    baseUrlImages +
                                        controller.model!.images[0]['image'],
                                  )));
                                },
                                child: Container(
                                  padding: EdgeInsetsDirectional.symmetric(
                                    vertical: ScreenDimensions.heightPercentage(
                                        context, 2),
                                  ),
                                  width: ScreenDimensions.screenWidth(context),
                                  height: ScreenDimensions.heightPercentage(
                                      context, 25),
                                  child: AppNetworkImage(
                                    baseUrlImages +
                                        controller.model!.images[0]['image'],
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenDimensions.heightPercentage(context, 10),
                                child: ProductImages(
                                  image: controller.model!.images,
                                  itemCount: controller.model!.images.length,
                                ),
                              ).paddingOnly(bottom: ScreenDimensions.heightPercentage(context, 2)),
                              Directions(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${AppWord.productName} ${AppWord.caliber} ${controller.model!.carat}',
                                      style: TextStyle(
                                          fontSize:
                                              AppFonts.subTitleFont(context)),
                                    ),
                                    Text(
                                      controller.model!.description,
                                      style: TextStyle(
                                          fontSize:
                                              AppFonts.smallTitleFont(context)),
                                    ).paddingSymmetric(
                                        vertical:
                                            ScreenDimensions.heightPercentage(
                                                context, 1)),
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
                                        details: controller.model!.manufacturer,
                                        title: AppWord.manufacturer,
                                        picPath: AppImages.building),
                                    Details(
                                        withIcon: true,
                                        details: controller.model!.age,
                                        title: AppWord.age,
                                        picPath: AppImages.age),
                                    Details(
                                        withIcon: true,
                                        details:
                                            '${controller.model!.weight.toString()} ${AppWord.grams}',
                                        title: AppWord.weight,
                                        picPath: AppImages.weightScale),
                                    Details(
                                        withIcon: true,
                                        details:
                                            '${controller.model!.currentGoldPrice.toString()} ${AppWord.sad}',
                                        title: AppWord.gramPrice,
                                        picPath: AppImages.priceTag),
                                    Details(
                                        withIcon: true,
                                        details:
                                            '${controller.model!.price.toString()} ${AppWord.sad}',
                                        title: AppWord.productPrice,
                                        picPath: AppImages.priceTag),
                                    Details(
                                        withIcon: true,
                                        details:
                                            controller.model!.carat.toString(),
                                        title: AppWord.productCalibre,
                                        picPath: AppImages.scale),
                                  ],
                                ),
                              ).paddingSymmetric(
                                  horizontal: ScreenDimensions.widthPercentage(
                                      context, 5)),
                              Directions(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FloatingContainer(
                                      title: AppWord.contactUs,
                                      picPath: AppImages.contactUs,
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
                                                      top: ScreenDimensions
                                                          .heightPercentage(
                                                              context, 5),
                                                      bottom: ScreenDimensions
                                                          .heightPercentage(
                                                              context, 50),
                                                      start: ScreenDimensions
                                                          .widthPercentage(
                                                              context, 5),
                                                      end: ScreenDimensions
                                                          .widthPercentage(
                                                              context, 5)),
                                                  padding:
                                                      EdgeInsetsDirectional.all(
                                                          ScreenDimensions
                                                              .widthPercentage(
                                                                  context, 3)),
                                                  color: CustomColors.white,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
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
                                                              AppWord.contactUs,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: AppFonts
                                                                      .smallTitleFont(
                                                                          context))),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {},
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      AppWord
                                                                          .usingEmail,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            AppFonts.smallTitleFont(context),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: ScreenDimensions
                                                                          .widthPercentage(
                                                                              context,
                                                                              3),
                                                                    ),
                                                                    SvgPicture
                                                                        .asset(
                                                                      AppImages
                                                                          .email,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {},
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      AppWord
                                                                          .usingWhatsApp,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            AppFonts.smallTitleFont(context),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: ScreenDimensions
                                                                          .widthPercentage(
                                                                              context,
                                                                              3),
                                                                    ),
                                                                    SvgPicture.asset(
                                                                        AppImages
                                                                            .whatsApp),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ).paddingSymmetric(
                                                              vertical: ScreenDimensions
                                                                  .heightPercentage(
                                                                      context,
                                                                      1)),
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  AppWord
                                                                      .sendNotification,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: AppFonts
                                                                        .smallTitleFont(
                                                                            context),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: ScreenDimensions
                                                                      .widthPercentage(
                                                                          context,
                                                                          3),
                                                                ),
                                                                SvgPicture.asset(
                                                                    AppImages
                                                                        .bubbleChats),
                                                              ],
                                                            ).paddingSymmetric(
                                                                vertical: ScreenDimensions
                                                                    .heightPercentage(
                                                                        context,
                                                                        1),
                                                                horizontal: ScreenDimensions
                                                                    .widthPercentage(
                                                                        context,
                                                                        14)),
                                                          ),
                                                        ],
                                                      ).paddingSymmetric(
                                                          vertical: ScreenDimensions
                                                              .heightPercentage(
                                                                  context, 3)),
                                                      Text(
                                                        AppWord.typeMessage,
                                                        style: TextStyle(
                                                          fontSize: AppFonts
                                                              .smallTitleFont(
                                                                  context),
                                                        ),
                                                      ).paddingSymmetric(
                                                          horizontal:
                                                              ScreenDimensions
                                                                  .widthPercentage(
                                                                      context,
                                                                      5)),
                                                      Container(
                                                        height: ScreenDimensions
                                                            .heightPercentage(
                                                                context, 18),
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
                                                          maxLines: 6,
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
                                                      ),
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
                                                      top: ScreenDimensions
                                                          .heightPercentage(
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
                                                  padding:
                                                      EdgeInsetsDirectional.all(
                                                          ScreenDimensions
                                                              .widthPercentage(
                                                                  context, 3)),
                                                  color: CustomColors.white,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
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
                                                                  .shareProduct,
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
                                                                        blurStyle:
                                                                            BlurStyle
                                                                                .outer,
                                                                        spreadRadius:
                                                                            1)
                                                                  ]),
                                                              child: SvgPicture
                                                                  .asset(AppImages
                                                                      .whatsApp)),
                                                        ],
                                                      ).paddingSymmetric(
                                                          vertical: ScreenDimensions
                                                              .heightPercentage(
                                                                  context, 5)),
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
                                                      top: ScreenDimensions
                                                          .heightPercentage(
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
                                                  padding: EdgeInsetsDirectional.all(
                                                          ScreenDimensions
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
                                                        AppWord.describeProblem,
                                                        style: TextStyle(
                                                            fontSize: AppFonts
                                                                .smallTitleFont(
                                                                    context)),
                                                      ).paddingOnly(
                                                          left: ScreenDimensions
                                                              .widthPercentage(
                                                                  context, 60)),
                                                      Container(
                                                        height: ScreenDimensions.heightPercentage(context, 15),
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
                                                          controller: controller.problemController,
                                                          maxLines: 5,
                                                          decoration: const InputDecoration(border: InputBorder.none,
                                                            enabledBorder: InputBorder.none,
                                                          ),
                                                        ).paddingSymmetric(
                                                            horizontal: ScreenDimensions.widthPercentage(context, 7)),
                                                      ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                                      AppButton(
                                                              text: Text(
                                                                AppWord.send,
                                                                style: TextStyle(
                                                                    color: CustomColors
                                                                        .white,
                                                                    fontSize: AppFonts
                                                                        .smallTitleFont(
                                                                            context),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              onTap: () {
                                                                controller.reportProblem();
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
                                    vertical: ScreenDimensions.widthPercentage(
                                        context, 2)),
                              ),
                              AppButton(
                                onTap: () {
                                  Get.to(const Invoice(),transition: Transition.zoom,duration: const Duration(milliseconds: 500));
                                },
                                text: Text(
                                  AppWord.requestYourPurchase,
                                  style: TextStyle(
                                    color: CustomColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFonts.smallTitleFont(context),
                                  ),
                                ),
                                buttonBackground:
                                    AppImages.buttonLiteBackground,
                              ).paddingSymmetric(
                                  vertical: ScreenDimensions.heightPercentage(
                                      context, 3)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
