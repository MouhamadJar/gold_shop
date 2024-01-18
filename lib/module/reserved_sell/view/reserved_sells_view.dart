import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/module/buy_order/view/buy_order_view.dart';
import 'package:gold_shop/module/reserved_sell/components/reserved_sell_components.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/images/images.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/dimensions.dart';

class ReservedSell extends StatelessWidget {
  const ReservedSell({super.key});

  @override
  Widget build(BuildContext context) {
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
          body: SizedBox(
            width: ScreenDimensions.screenWidth(context),
            height: ScreenDimensions.screenHeight(context),
            child: Column(
              children: [
                const PricesBar(),
                SizedBox(
                  height: ScreenDimensions.heightPercentage(context, 3),
                ),
                AdvertisementBanner(items: [],),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: '${AppWord.productState} : ',
                                  style: TextStyle(
                                      fontSize: AppFonts.subTitleFont(context),
                                      color: CustomColors.yellow,
                                      shadows: [
                                        Shadow(
                                            blurRadius: 3,
                                            color: CustomColors.shadow),
                                      ])),
                              TextSpan(
                                  text: AppWord.reserved,
                                  style: TextStyle(
                                      fontSize: AppFonts.subTitleFont(context),
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
                                child:
                                SvgPicture.asset(AppImages.bannerImage1)));
                          },
                          child: Container(
                            padding: EdgeInsetsDirectional.symmetric(
                              vertical:
                              ScreenDimensions.heightPercentage(context, 2),
                            ),
                            width: ScreenDimensions.screenWidth(context),
                            height:
                            ScreenDimensions.heightPercentage(context, 25),
                            child: SvgPicture.asset(AppImages.bannerImage1),
                          ),
                        ),
                        SizedBox(
                          height:
                          ScreenDimensions.heightPercentage(context, 10),
                          child: const ProductImages(
                            itemCount: 5,
                          ),
                        ),
                        SizedBox(
                          height: ScreenDimensions.heightPercentage(context, 4),
                          width: ScreenDimensions.screenWidth(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ScrollingContainer(color: CustomColors.white),
                              ScrollingContainer(color: CustomColors.yellow),
                              ScrollingContainer(color: CustomColors.white),
                            ],
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
                                    'GN12345',
                                    style: TextStyle(
                                      fontSize: AppFonts.subTitleFont(context),
                                      color: CustomColors.black,
                                    ),
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${AppWord.productName} ',
                                            ),
                                            TextSpan(
                                              text: '${AppWord.caliber} ',
                                            ),
                                            const TextSpan(
                                              text: '18',
                                            ),
                                          ],
                                          style: TextStyle(
                                              color: CustomColors.black,
                                              fontSize: AppFonts.subTitleFont(
                                                  context)))),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: ScreenDimensions.heightPercentage(
                                        context, 1)),
                                child: Text(
                                  AppWord.description,
                                  style: TextStyle(
                                      fontSize:
                                      AppFonts.smallTitleFont(context)),
                                ),
                              ),
                              Text(
                                AppWord.productDetails,
                                style: TextStyle(
                                    fontSize: AppFonts.subTitleFont(context),
                                    color: CustomColors.yellow,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 3,
                                          color: CustomColors.shadow),
                                    ]),
                              ),
                              Details(details: AppWord.details,
                                  title: AppWord.manufacturer,
                                  picPath: AppImages.building),
                              Details(details: AppWord.details,
                                  title: AppWord.age, picPath: AppImages.age),
                              Details(details: AppWord.details,
                                  title: AppWord.weight,
                                  picPath: AppImages.weightScale),
                              Details(details: AppWord.details,
                                  title: AppWord.gramPrice,
                                  picPath: AppImages.priceTag),
                              Details(details: AppWord.details,
                                  title: AppWord.productPrice,
                                  picPath: AppImages.priceTag),
                              Details(details: AppWord.details,
                                  title: AppWord.productCalibre,
                                  picPath: AppImages.scale),
                            ],
                          ),
                        ).paddingSymmetric(
                            horizontal:
                            ScreenDimensions.widthPercentage(context, 5)),
                        Directions(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppWord.purchaseProcessInfo,
                                style: TextStyle(
                                    fontSize: AppFonts.subTitleFont(context),
                                    color: CustomColors.yellow,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 3,
                                          color: CustomColors.shadow),
                                    ]),
                              ),
                              ReservedSellProcessDetails(
                                  title: AppWord.amountPaid,
                                  subtitle: AppWord.sad,
                                  amount: '2310'),
                              ReservedSellProcessDetails(
                                  title: AppWord.productPrice,
                                  subtitle: AppWord.sad,
                                  amount: '2000'),
                              ReservedSellProcessDetails(
                                  title: AppWord.gramPrice,
                                  subtitle: AppWord.sad,
                                  amount: '300'),
                              ReservedSellProcessDetails(
                                  title: AppWord.appServiceCost,
                                  subtitle: AppWord.sad,
                                  amount: '10'),
                              ReservedSellProcessDetails(
                                title: AppWord.buyerName,
                                subtitle: AppWord.buyerName,
                              ),
                              ReservedSellProcessDetails(
                                title: AppWord.buyerNumber,
                                subtitle: '904358345',
                              ),
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
                            Text(
                              'السعودية, المدينة المنورة , حي النبلاء',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFonts.smallTitleFont(context)),
                            ),
                            SizedBox(
                              width:
                              ScreenDimensions.widthPercentage(context, 1),
                            ),
                            SvgPicture.asset(
                              AppImages.location,
                            ),
                          ],
                        ),
                        Container(
                          width: ScreenDimensions.screenWidth(context),
                          height:
                          ScreenDimensions.heightPercentage(context, 15),
                          decoration: BoxDecoration(border: Border.all()),
                        ).paddingSymmetric(
                            vertical:
                            ScreenDimensions.heightPercentage(context, 2)),
                        Directions(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                            padding: EdgeInsetsDirectional.all(
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
                                                            .shareProductOnWhatsapp,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
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
                                                        padding: EdgeInsetsDirectional
                                                            .all(ScreenDimensions
                                                            .widthPercentage(
                                                            context,
                                                            4)),
                                                        decoration:
                                                        BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 5,
                                                                  color:
                                                                  CustomColors
                                                                      .shadow,
                                                                  blurStyle:
                                                                  BlurStyle
                                                                      .outer,
                                                                  spreadRadius:
                                                                  1)
                                                            ]),
                                                        child: SvgPicture.asset(
                                                            AppImages
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
                                              CrossAxisAlignment.center,
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
                                                    Text(AppWord.reportProblem,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
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
                                                        onSelected: (value) {}),
                                                    Text(
                                                      AppWord.defineProblem,
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
                                                  height: ScreenDimensions
                                                      .heightPercentage(
                                                      context, 15),
                                                  margin: EdgeInsetsDirectional
                                                      .symmetric(
                                                      horizontal:
                                                      ScreenDimensions
                                                          .widthPercentage(
                                                          context,
                                                          8)),
                                                  decoration: BoxDecoration(
                                                      border: Border.all()),
                                                  child: TextFormField(
                                                    maxLines: 5,
                                                    decoration:
                                                    const InputDecoration(
                                                      enabledBorder:
                                                      InputBorder.none,
                                                    ),
                                                  ).paddingSymmetric(
                                                      horizontal:
                                                      ScreenDimensions
                                                          .widthPercentage(
                                                          context, 7)),
                                                ).paddingSymmetric(
                                                    vertical: ScreenDimensions
                                                        .heightPercentage(
                                                        context, 2)),
                                                AppButton(
                                                    text: Text(
                                                      AppWord.send,
                                                      style: TextStyle(
                                                          color:
                                                          CustomColors
                                                              .white,
                                                          fontSize: AppFonts
                                                              .smallTitleFont(
                                                              context),
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    buttonBackground: AppImages
                                                        .buttonLiteBackground)
                                                    .paddingSymmetric(
                                                    vertical: ScreenDimensions
                                                        .heightPercentage(
                                                        context, 1)),
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
                              ScreenDimensions.widthPercentage(context, 2)),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.symmetric(horizontal: ScreenDimensions.widthPercentage(context, 5)),
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            AppWord.confirmPayingProcess,
                            style: TextStyle(
                                fontSize: AppFonts.smallTitleFont(context)),
                          ),
                        ),
                        Container(
                          height:
                          ScreenDimensions.heightPercentage(context, 10),
                          margin: EdgeInsetsDirectional.symmetric(
                              horizontal:
                              ScreenDimensions.widthPercentage(context, 8)),
                          decoration: BoxDecoration(border: Border.all()),
                          child: TextFormField(
                            maxLines: 5,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                            ),
                          ).paddingSymmetric(
                              horizontal:
                              ScreenDimensions.widthPercentage(context, 7)),
                        ).paddingSymmetric(
                            vertical:
                            ScreenDimensions.heightPercentage(context, 2)),
                        GestureDetector(onTap: (){
                          Get.to(const BuyOrder(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 500));
                        },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: ScreenDimensions.widthPercentage(context, 30),
                            height: ScreenDimensions.heightPercentage(context, 5),
                            decoration: BoxDecoration(border: Border.all(color: CustomColors.gold)),
                            child: Text(
                              AppWord.buyOrder,
                              style: TextStyle(
                                  color: CustomColors.gold,
                                  fontSize: AppFonts.smallTitleFont(context),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                        AppButton(
                          onTap: () {},
                          text: Text(
                            AppWord.downloadPDFFile,
                            style: TextStyle(
                              color: CustomColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AppFonts.smallTitleFont(context),
                            ),
                          ),
                          buttonBackground: AppImages.buttonDarkBackground,
                        ).paddingSymmetric(
                            vertical:
                            ScreenDimensions.heightPercentage(context, 1)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
