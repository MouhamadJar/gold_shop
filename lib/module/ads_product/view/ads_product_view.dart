import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/components/problem_dialog.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/ads_product/controller/ads_product_controller.dart';
import 'package:gold_shop/module/update_product/view/update_product_view.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/images/images.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../core/utils/app_network_image.dart';
import '../../main/user/view/main_screen_view.dart';
import '../components/ads_product_components.dart';

class AdsProduct extends GetView<AdsProductController> {
  const AdsProduct({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    Get.put(AdsProductController());
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
          body: GetBuilder<AdsProductController>(initState: (state) {
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
                        controller.isSubcategoryLoading
                            ? Center(child: CircularProgressIndicator(color: CustomColors.gold,),):controller.isBannersEmpty
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
                                  children: [
                                    Text(
                                      controller.subcategoriesADVS[index].paragraph,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              AppFonts.smallTitleFont(context)),
                                    ),
                                    AppNetworkImage(
                                      baseUrlImages + controller.subcategoriesADVS[index].image,
                                      fit: BoxFit.contain,
                                      height: ScreenDimensions.heightPercentage(context, 5),
                                      width: ScreenDimensions.widthPercentage(context, 25),
                                    ),
                                  ],
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
                                      text: controller.getProductState(controller.model!.productStatus),
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
                                    Get.dialog(InteractiveViewer(
                                        child: AppNetworkImage(baseUrlImages + controller.model!.images[0]['image'],),),);
                                  },
                                  child: Container(
                                    padding: EdgeInsetsDirectional.symmetric(
                                      vertical:
                                          ScreenDimensions.heightPercentage(
                                              context, 2),
                                    ),
                                    width: ScreenDimensions.screenWidth(context),
                                    height: ScreenDimensions.heightPercentage(context, 25),
                                    child: AppNetworkImage (baseUrlImages + controller.model!.images[0]['image']),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenDimensions.heightPercentage(
                                      context, 10),
                                  child:  ProductImages(
                                    image: controller.model!.images,
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
                                                  text: controller.model!.carat,
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
                                          details: controller.productType!,
                                          title: AppWord.productType,
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
                                          details: controller.model!.price.toInt().toString(),
                                          title: AppWord.productPrice,
                                          picPath: AppImages.priceTag),
                                      Details(
                                          withIcon: true,
                                          details: controller.model!.carat.toString(),
                                          title: AppWord.productCalibre,
                                          picPath: AppImages.scale),
                                    ],
                                  ),
                                ).paddingSymmetric(
                                    horizontal: ScreenDimensions.widthPercentage(context, 5)),
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
                                      AdsProcessDetails(
                                          title: AppWord.productPrice,
                                          subtitle: AppWord.sad,
                                          amount: controller.model!.price.toInt().toString()),
                                      AdsProcessDetails(
                                          title: AppWord.marketValue,
                                          subtitle: AppWord.sad,
                                          amount: controller.model!.marketValue!.toInt().toString()),
                                      AdsProcessDetails(
                                          title: AppWord.gramPrice,
                                          subtitle: AppWord.sad,
                                          amount: controller.model!.currentGoldPrice.toInt().toString()),
                                      const PhoneNumbersFields()
                                    ],
                                  ).paddingSymmetric(
                                      vertical:
                                          ScreenDimensions.heightPercentage(context, 2),
                                      horizontal:
                                          ScreenDimensions.widthPercentage(context, 5)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: ScreenDimensions.widthPercentage(context, 90),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(text: ' ${controller.model!.country} '),
                                            TextSpan(text: ' ${controller.model!.city} '),
                                          ],),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppFonts.smallTitleFont(context)),
                                      ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 1)),
                                    ),
                                    SvgPicture.asset(
                                      AppImages.location,
                                    ),
                                  ],
                                ),
                                Directions(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
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
                                                    padding: EdgeInsetsDirectional.all(ScreenDimensions
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
                                                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(
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
                                          showProblemDialog(context: context, productId: productId);
                                        },
                                      ),
                                    ],
                                  ).paddingSymmetric(
                                      vertical:
                                          ScreenDimensions.widthPercentage(
                                              context, 2)),
                                ),
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
                                    vertical: ScreenDimensions.heightPercentage(context, 1)),
                                AppButton(
                                  onTap: () {
                                    Get.to(UpdateProduct(productId: controller.model!.id),transition: Transition.fade,duration: const Duration(milliseconds: 700));
                                    Get.snackbar(AppWord.warning, AppWord.updateAllInformation);
                                  },
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
                                    vertical: ScreenDimensions.heightPercentage(context, 1)),
                                AppButton(
                                  buttonBackground:
                                      AppImages.redButtonBackground,
                                  text: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppWord.deleteProduct,
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
                                      SvgPicture.asset(AppImages.delete),
                                    ],
                                  ),
                                  onTap: () {
                                    Get.dialog(Material(
                                      color: Colors.transparent,
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaY: 10, sigmaX: 10),
                                        child: Container(
                                          color: CustomColors.white,
                                          margin: EdgeInsetsDirectional.only(
                                            top: ScreenDimensions
                                                .heightPercentage(context, 5),
                                            start: ScreenDimensions
                                                .widthPercentage(context, 5),
                                            end: ScreenDimensions
                                                .widthPercentage(context, 5),
                                            bottom: ScreenDimensions
                                                .heightPercentage(context, 70),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                AppWord.areYouSureYouWantToDeleteProduct,
                                                style: TextStyle(
                                                    fontSize:
                                                        AppFonts.smallTitleFont(
                                                            context)),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                      if(controller.model!.productStatus =='0'){
                                                        controller.deleteProduct(productId: controller.model!.id);
                                                        return;
                                                      }
                                                      else if(controller.model!.productStatus == '3'){
                                                        Future.any([
                                                          Get.dialog(Material(
                                                            color: Colors.transparent,
                                                            child: BackdropFilter(
                                                                filter: ImageFilter.blur(
                                                                    sigmaX: 10,
                                                                    sigmaY: 10),
                                                                child: Container(
                                                                  margin: EdgeInsetsDirectional.only(
                                                                      top: ScreenDimensions.heightPercentage(
                                                                          context,
                                                                          5),
                                                                      bottom: ScreenDimensions.heightPercentage(
                                                                          context,
                                                                          60),
                                                                      start: ScreenDimensions
                                                                          .widthPercentage(
                                                                          context,
                                                                          5),
                                                                      end: ScreenDimensions
                                                                          .widthPercentage(
                                                                          context,
                                                                          5)),
                                                                  alignment: AlignmentDirectional.center,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                      CustomColors
                                                                          .gold,
                                                                      borderRadius:
                                                                      BorderRadius.circular(ScreenDimensions.heightPercentage(
                                                                          context,
                                                                          1))),
                                                                  child: Text(
                                                                    AppWord.youCantDeleteProductSold,
                                                                    style: TextStyle(
                                                                        fontSize: AppFonts.smallTitleFont(context)),
                                                                  ),
                                                                )),
                                                          )),
                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 3))
                                                              .then((_) {
                                                            Get.back();
                                                            Get.offAll(
                                                                    () => const MainScreen(),
                                                                transition: Transition.fadeIn,
                                                                duration: const Duration(milliseconds: 500));
                                                          }),
                                                        ]);
                                                        return;
                                                      }
                                                      else if(controller.model!.productStatus == '1'||controller.model!.productStatus == '2'){
                                                        Future.any([
                                                          Get.dialog(Material(
                                                            color: Colors.transparent,
                                                            child: BackdropFilter(
                                                                filter: ImageFilter.blur(
                                                                    sigmaX: 10,
                                                                    sigmaY: 10),
                                                                child: Container(
                                                                  margin: EdgeInsetsDirectional.only(
                                                                      top: ScreenDimensions.heightPercentage(
                                                                          context,
                                                                          5),
                                                                      bottom: ScreenDimensions.heightPercentage(
                                                                          context,
                                                                          60),
                                                                      start: ScreenDimensions
                                                                          .widthPercentage(
                                                                          context,
                                                                          5),
                                                                      end: ScreenDimensions
                                                                          .widthPercentage(
                                                                          context,
                                                                          5)),
                                                                  alignment: AlignmentDirectional.center,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                      CustomColors
                                                                          .gold,
                                                                      borderRadius:
                                                                      BorderRadius.circular(ScreenDimensions.heightPercentage(
                                                                          context,
                                                                          1))),
                                                                  child: Text(
                                                                    AppWord.youCantDeleteProductReserved,
                                                                    style: TextStyle(
                                                                        fontSize: AppFonts.smallTitleFont(context)),
                                                                  ),
                                                                )),
                                                          )),
                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 3))
                                                              .then((_) {
                                                            Get.back();
                                                            Get.offAll(
                                                                    () => const MainScreen(),
                                                                transition: Transition.fadeIn,
                                                                duration: const Duration(milliseconds: 500));
                                                          }),
                                                        ]);
                                                        return;
                                                      }
                                                    },
                                                    child: Container(
                                                      alignment: AlignmentDirectional.center,
                                                      width: ScreenDimensions.widthPercentage(context, 10),
                                                      height: ScreenDimensions.heightPercentage(context, 5),
                                                      child: Text(
                                                        AppWord.yes,
                                                        style: TextStyle(
                                                            fontSize: AppFonts.smallTitleFont(context)),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      alignment: AlignmentDirectional.center,
                                                      width: ScreenDimensions.widthPercentage(context, 10),
                                                      height: ScreenDimensions.heightPercentage(context, 5),
                                                      child: Text(
                                                        AppWord.no,
                                                        style: TextStyle(
                                                            fontSize: AppFonts.smallTitleFont(context)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                                  },
                                ).paddingSymmetric(
                                    vertical: ScreenDimensions.heightPercentage(context, 1)),
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
