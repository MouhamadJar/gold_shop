import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/module/invoice/view/invoice_view.dart';
import '../../../../../core/colors/colors.dart';
import '../../../../../core/images/images.dart';
import '../../../../../core/texts/words.dart';
import '../../../../../core/utils/app_fonts.dart';
import '../../../../../core/utils/app_network_image.dart';
import '../../../../../core/utils/dimensions.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directions(
        child: Scaffold(
          backgroundColor: CustomColors.white,
          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.all(
                  ScreenDimensions.widthPercentage(context, 1),
                ),
                child: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward,
                      color: CustomColors.black,
                    ),
                    onTap: () {
                      Get.back();
                    }),
              )
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
            leading: const SizedBox(),
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
                AdvertisementBanner(
                  itemBuilder: (context, index, realIndex) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppNetworkImage(
                          '',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: AppFonts.smallTitleFont(context)),
                        ),
                      ),
                    ],
                  ),
                  itemCount: 0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.dialog(BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                              child: InteractiveViewer(
                                  child:
                                      SvgPicture.asset(AppImages.bannerImage1)),
                            ));
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
                              Text(
                                '${AppWord.productName} ${AppWord.caliber} 18',
                                style: TextStyle(
                                    fontSize: AppFonts.subTitleFont(context)),
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
                              Details(
                                  details: AppWord.details,
                                  onTap: () {},
                                  isRequired: true,
                                  title: AppWord.manufacturer,
                                  picPath: AppImages.building),
                              Details(
                                  details: AppWord.details,
                                  title: AppWord.age,
                                  picPath: AppImages.age),
                              Details(
                                  details: AppWord.details,
                                  isRequired: true,
                                  onTap: () {},
                                  title: AppWord.weight,
                                  picPath: AppImages.weightScale),
                              Details(
                                  details: AppWord.details,
                                  title: AppWord.gramPrice,
                                  picPath: AppImages.priceTag),
                              Details(
                                  details: AppWord.details,
                                  title: AppWord.productPrice,
                                  picPath: AppImages.priceTag),
                              Details(
                                  details: AppWord.details,
                                  isRequired: true,
                                  onTap: () {},
                                  title: AppWord.productCalibre,
                                  picPath: AppImages.scale),
                              SizedBox(
                                height: ScreenDimensions.heightPercentage(
                                    context, 2),
                              ),
                              Details(
                                title: AppWord.vendorName,
                                picPath: '',
                                details: AppWord.vendorName,
                                withIcon: false,
                              ),
                              Details(
                                title: AppWord.buyerName,
                                picPath: '',
                                details: AppWord.buyerName,
                                withIcon: false,
                              ),
                            ],
                          ),
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.widthPercentage(context, 5)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppWord.addNote,
                              style: TextStyle(
                                  fontSize: AppFonts.smallTitleFont(context)),
                            ),
                            AppTextField(
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                            )
                          ],
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.widthPercentage(context, 5),
                            vertical:
                                ScreenDimensions.heightPercentage(context, 3)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsetsDirectional.all(
                                    ScreenDimensions.widthPercentage(
                                        context, 4)),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: CustomColors.shadow,
                                      blurStyle: BlurStyle.outer,
                                      spreadRadius: 1)
                                ]),
                                child: SvgPicture.asset(AppImages.whatsApp)),
                            Text(AppWord.shareProduct,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        AppFonts.smallTitleFont(context))),
                          ],
                        ).paddingSymmetric(
                            horizontal:
                                ScreenDimensions.widthPercentage(context, 10)),
                        AppButton(
                          onTap: () {
                            Get.dialog(Material(
                              color: Colors.transparent,
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                    color: CustomColors.white,
                                    margin: EdgeInsetsDirectional.only(
                                        top: ScreenDimensions.heightPercentage(
                                            context, 5),
                                        start: ScreenDimensions.widthPercentage(
                                            context, 5),
                                        end: ScreenDimensions.widthPercentage(
                                            context, 5),
                                        bottom:
                                            ScreenDimensions.heightPercentage(
                                                context, 50)),
                                    padding: EdgeInsetsDirectional.all(
                                        ScreenDimensions.widthPercentage(
                                            context, 5)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: SizedBox(
                                                    child: SvgPicture.asset(
                                                        AppImages.x,height: ScreenDimensions.heightPercentage(context, 1.5),))),
                                          ],
                                        ),
                                        Text(AppWord.invoiceWillBeSent,
                                            style: TextStyle(
                                                fontSize:
                                                AppFonts.smallTitleFont(
                                                    context),
                                                fontWeight:
                                                FontWeight.bold)).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                        Text(AppWord.alsoInvoiceWillBeNamed,
                                            style: TextStyle(
                                                fontSize:
                                                AppFonts.smallTitleFont(
                                                    context),
                                                fontWeight:
                                                FontWeight.bold)).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                        Text(AppWord.areYouSure,
                                            style: TextStyle(
                                                fontSize:
                                                AppFonts.smallTitleFont(
                                                    context),
                                                fontWeight:
                                                FontWeight.bold)).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                          Container(
                                            alignment: AlignmentDirectional.center,
                                            width: ScreenDimensions.widthPercentage(context, 6),
                                            height: ScreenDimensions.widthPercentage(context, 6),
                                            child: GestureDetector(
                                              onTap: (){},
                                              child: Text(AppWord.yes,
                                                  style: TextStyle(
                                                      fontSize:
                                                      AppFonts.smallTitleFont(
                                                          context),
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          ),
                                          Container(
                                            alignment: AlignmentDirectional.center,
                                            width: ScreenDimensions.widthPercentage(context, 6),
                                            height: ScreenDimensions.widthPercentage(context, 6),
                                            child: GestureDetector(
                                              onTap: (){Get.back();},
                                              child: Text(AppWord.no,
                                                  style: TextStyle(
                                                      fontSize:
                                                      AppFonts.smallTitleFont(
                                                          context),
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          ),
                                        ],).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                        const Spacer(),
                                        Center(
                                          child: AppButton(text:
                                          Text(AppWord.send,
                                              style: TextStyle(
                                                color: CustomColors.white,
                                                  fontSize:
                                                  AppFonts.smallTitleFont(
                                                      context),
                                                  fontWeight:
                                                  FontWeight.bold)), onTap: (){}, buttonBackground: AppImages.buttonLiteBackground),
                                        )
                                      ],
                                    )),
                              ),
                            ));
                          },
                          text: Text(
                            AppWord.saveAndSend,
                            style: TextStyle(
                              color: CustomColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AppFonts.smallTitleFont(context),
                            ),
                          ),
                          buttonBackground: AppImages.buttonLiteBackground,
                        ).paddingSymmetric(
                            vertical:
                                ScreenDimensions.heightPercentage(context, 3)),
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
