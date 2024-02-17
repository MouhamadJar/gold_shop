import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/components/problem_dialog.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/invoice/controller/invoice_controller.dart';
import 'package:gold_shop/module/main/user/view/main_screen_view.dart';

import '../../../core/colors/colors.dart';

class Invoice extends GetView<InvoiceController> {
  const Invoice({super.key,required this.orderId});
  final int orderId;
  @override
  Widget build(BuildContext context) {
    Get.put(InvoiceController());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.white,
        appBar: AppBar(
          backgroundColor: CustomColors.white,
          elevation: 1,
          centerTitle: true,
          leading: const BackArrow(),
          title: Text(
            AppWord.invoice,
            style: TextStyle(
                fontSize: AppFonts.subTitleFont(context),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<InvoiceController>(
          initState: (state){
            controller.getInvoiceData(orderId: orderId);
            controller.getAppCommission();
          },
          builder: (_) {
            return controller.isLoading?Center(child: CircularProgressIndicator(color: CustomColors.gold,),):SizedBox(
              width: ScreenDimensions.screenWidth(context),
              height: ScreenDimensions.screenHeight(context),
              child: Directions(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: '${controller.invoiceModel!.firstName} ${controller.invoiceModel!.lastName}'),
                          const TextSpan(text: ' : '),
                          TextSpan(text: AppWord.userName),
                        ],
                        style: TextStyle(
                            color: CustomColors.black,
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 1)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: (controller.commission + controller.invoiceModel!.price+controller.invoiceModel!.currentGoldPrice).toString()),
                          const TextSpan(text: ' : '),
                          TextSpan(text: AppWord.amountPaid),
                        ],
                        style: TextStyle(
                            color: CustomColors.black,
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 1)),
                    Text(
                      textDirection: TextDirection.rtl,
                      AppWord.reservedProduct,
                      style: TextStyle(
                          shadows: [
                            Shadow(blurRadius: 3, color: CustomColors.shadow)
                          ],
                          color: CustomColors.yellow,
                          fontSize: AppFonts.subTitleFont(context),
                          fontWeight: FontWeight.bold),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 3)),
                    Container(
                            padding: EdgeInsetsDirectional.symmetric(
                                vertical: ScreenDimensions.heightPercentage(context, 2),
                                    horizontal: ScreenDimensions.widthPercentage(context, 2)),
                            decoration: BoxDecoration(border: Border.all()),
                            child: Directions(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: ScreenDimensions.widthPercentage(context, 35),
                                    child: Column(
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: TextStyle(
                                                color: CustomColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppFonts.smallTitleFont(context)),
                                            children: [
                                              TextSpan(
                                                  text: AppWord.productName,),
                                              TextSpan(
                                                  text: ' ${AppWord.productCalibre}',),
                                               TextSpan(
                                                  text: '${controller.invoiceModel!.carat}',),
                                            ],
                                          ),
                                        ),
                                        Text(
                                            controller.invoiceModel!.description,
                                            maxLines: 5,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      ],
                                    ),
                                  ),
                                  AppNetworkImage(
                                      baseUrlImages + controller.invoiceModel!.images[0]['image'],
                                    height: ScreenDimensions.heightPercentage(context, 15),
                                    width: ScreenDimensions.widthPercentage(context, 20),
                                  ),
                                ],
                              ),
                            )).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 3)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: AppWord.productPrice),
                          const TextSpan(text: ' : '),
                          TextSpan(text: '${controller.invoiceModel!.price} '),
                          TextSpan(text: AppWord.sad),
                        ],
                        style: TextStyle(
                            color: CustomColors.black,
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 1)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: AppWord.gramPrice),
                          const TextSpan(text: ' : '),
                          TextSpan(text: '${controller.invoiceModel!.currentGoldPrice} '),
                          TextSpan(text: AppWord.sad),
                        ],
                        style: TextStyle(
                            color: CustomColors.black,
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 1)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: AppWord.servicePrice),
                          const TextSpan(text: ' : '),
                          TextSpan(text: '${controller.commission} '),
                          TextSpan(text: AppWord.sad),
                        ],
                        style: TextStyle(
                            color: CustomColors.black,
                            fontSize: AppFonts.smallTitleFont(context),
                            fontWeight: FontWeight.bold),
                      ),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingContainer(
                            title: AppWord.shareProduct, picPath: AppImages.share, onTap: () {
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
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
                                            Text(AppWord.shareProduct,
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: AppFonts
                                                        .smallTitleFont(
                                                        context))),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: (){},
                                          child: Align(
                                             alignment: Alignment.center,
                                            child: Container(
                                                padding: EdgeInsetsDirectional.all(ScreenDimensions.widthPercentage(context, 4)),
                                                decoration:
                                                BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 5,
                                                          color: CustomColors.shadow,
                                                          blurStyle: BlurStyle.outer,
                                                          spreadRadius: 1)
                                                    ]),
                                                child: SvgPicture.asset(
                                                    AppImages.whatsApp)),
                                          ),
                                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 5)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );},),
                        FloatingContainer(
                            title: AppWord.reportProblem,
                            picPath: AppImages.report,
                          onTap: () {
                              showProblemDialog(context: context, productId: controller.invoiceModel!.productId);
                          // Get.dialog(
                          //   Directions(
                          //     child: Material(
                          //       color: Colors.transparent,
                          //       child: BackdropFilter(
                          //         filter: ImageFilter.blur(
                          //             sigmaY: 10, sigmaX: 10),
                          //         child: Container(
                          //           margin: EdgeInsetsDirectional.only(
                          //               top: ScreenDimensions
                          //                   .heightPercentage(
                          //                   context, 5),
                          //               bottom: ScreenDimensions
                          //                   .heightPercentage(
                          //                   context, 45),
                          //               start: ScreenDimensions
                          //                   .widthPercentage(
                          //                   context, 5),
                          //               end: ScreenDimensions
                          //                   .widthPercentage(
                          //                   context, 5)),
                          //           padding: EdgeInsetsDirectional.all(
                          //               ScreenDimensions
                          //                   .widthPercentage(
                          //                   context, 3)),
                          //           color: CustomColors.white,
                          //           child: Column(
                          //             crossAxisAlignment:
                          //             CrossAxisAlignment.center,
                          //             children: [
                          //               Row(
                          //                 mainAxisAlignment:
                          //                 MainAxisAlignment
                          //                     .spaceBetween,
                          //                 children: [
                          //                   GestureDetector(
                          //                       onTap: () {
                          //                         Get.back();
                          //                       },
                          //                       child: SvgPicture.asset(
                          //                           AppImages.x,
                          //                           width: ScreenDimensions
                          //                               .widthPercentage(
                          //                               context,
                          //                               3))),
                          //                   Text(AppWord.reportProblem,
                          //                       style: TextStyle(
                          //                           fontWeight:
                          //                           FontWeight
                          //                               .bold,
                          //                           fontSize: AppFonts
                          //                               .smallTitleFont(
                          //                               context))),
                          //                 ],
                          //               ),
                          //               Row(
                          //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //                 children: [
                          //                   AppPopUpMenu(title: '', items: [], onSelected: (value){}),
                          //                   Text(AppWord.defineProblem,style: TextStyle(fontSize: AppFonts.smallTitleFont(context),),),
                          //                 ],
                          //               ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 4),),
                          //               Text(AppWord.describeProblem,style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),).paddingOnly(left: ScreenDimensions.widthPercentage(context, 60)),
                          //               Container(
                          //                 height: ScreenDimensions.heightPercentage(context, 15),
                          //                 margin: EdgeInsetsDirectional.symmetric(horizontal: ScreenDimensions.widthPercentage(context, 8)),
                          //                 decoration: BoxDecoration(border: Border.all()),
                          //                 child: TextFormField(
                          //                   maxLines:4 ,
                          //                   decoration:
                          //                   const InputDecoration(
                          //                     enabledBorder: InputBorder.none,
                          //                   ),
                          //                 ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 7)),
                          //               ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                          //               AppButton(text: Text(AppWord.send,style: TextStyle(color: CustomColors.white,fontSize: AppFonts.smallTitleFont(context),fontWeight: FontWeight.bold),), onTap: (){Get.back();}, buttonBackground: AppImages.buttonLiteBackground).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // );
                          },),
                      ],
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.widthPercentage(context, 2)),
                    Center(
                      child: AppButton(
                          text: Text(AppWord.downloadPDFFile,
                              style: TextStyle(color: CustomColors.white,fontSize: AppFonts.smallTitleFont(context))),
                          onTap: () {},
                          buttonBackground: AppImages.buttonDarkBackground),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 1)),
                    Center(
                      child: AppButton(
                          text: Text(AppWord.continues,
                              style: TextStyle(color: CustomColors.white,fontSize: AppFonts.smallTitleFont(context))),
                          onTap: () {
                            controller.getPaymentInfo();
                            Get.dialog(Directions(
                                child: Material(
                                  color: Colors.transparent,
                                  child: GetBuilder<InvoiceController>(
                                      builder: (_) {
                                        return controller.paymentInfoLoading? Center(child: CircularProgressIndicator(color: CustomColors.gold,)):AppDialog(
                                          expand: true,
                                          title: AppWord.payingReservationPolicy,
                                          description: controller.paymentInfoModel!.paymentInfo,
                                          card1: Text(
                                            AppWord.wishYouLovelyShopping,
                                            style: TextStyle(
                                                fontSize: AppFonts.smallTitleFont(context)),
                                          ),
                                          buttonName: AppWord.continueRequest,
                                          card2: SizedBox(
                                            width: ScreenDimensions.widthPercentage(context, 90),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                  Text(
                                                    AppWord.acceptWhatIsWritten,
                                                    style: TextStyle(
                                                        fontSize: AppFonts.smallTitleFont(context)),
                                                  ),
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        AppWord.politicalPrivacy,
                                                        style: TextStyle(
                                                            fontSize: AppFonts.smallTitleFont(context)),
                                                      ),
                                                    ),],),
                                                GetBuilder<InvoiceController>(
                                                  builder: (_) {
                                                    return Checkbox(
                                                      checkColor: CustomColors.white,
                                                      activeColor: CustomColors.gold,
                                                      value: controller.isChecked,
                                                      onChanged: (value) {
                                                        controller.checked();
                                                        value = controller.isChecked;
                                                      },
                                                    );
                                                  }
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: controller.isChecked
                                              ? () {
                                            Get.back();
                                            controller.getBankInfo();
                                            Get.dialog(Material(
                                              color: Colors
                                                  .transparent,
                                              child: GetBuilder<InvoiceController>(
                                                builder: (_) {
                                                  return Directions(
                                                    child: controller.bankInfoLoading? Center(child: CircularProgressIndicator(color: CustomColors.gold,)):AppDialog(
                                                      expand: true,
                                                      title: AppWord.bankTransferInfo,
                                                      description: controller.bankInfoModel!.paymentInfo,
                                                      card1: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: (){},
                                                            child: Container(
                                                                padding: EdgeInsetsDirectional.all(ScreenDimensions.widthPercentage(context, 4)),
                                                                decoration: BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          blurRadius: 5,
                                                                          color: CustomColors.shadow,
                                                                          blurStyle: BlurStyle.outer,
                                                                          spreadRadius: 1)
                                                                    ]),
                                                                child: SvgPicture.asset(
                                                                    AppImages
                                                                        .whatsApp)),
                                                          ),
                                                          Text(
                                                            AppWord
                                                                .share,
                                                            style: TextStyle(
                                                                color: CustomColors
                                                                    .black,
                                                                fontSize:
                                                                AppFonts.smallTitleFont(context)),
                                                          ),
                                                        ],
                                                      ),
                                                      card2: AppButton(
                                                        text: Text(
                                                          AppWord
                                                              .downloadPDFFile,
                                                          style: TextStyle(
                                                              fontSize:
                                                              AppFonts.smallTitleFont(
                                                                  context),
                                                              color: CustomColors
                                                                  .white,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        onTap: () {},
                                                        buttonBackground:
                                                        AppImages
                                                            .buttonDarkBackground,
                                                      ),
                                                      onTap: () {
                                                        Get.back();
                                                        Get.dialog(
                                                            Material(
                                                              color: Colors.transparent,
                                                              child:
                                                              Directions(
                                                                child: AppDialog(
                                                                  card1: GestureDetector(
                                                                    onTap: controller.pickImage,
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 1)),
                                                                          boxShadow: [
                                                                            BoxShadow(color: CustomColors.shadow, blurStyle: BlurStyle.outer, blurRadius: 5, spreadRadius: 2)
                                                                          ]),
                                                                      height: ScreenDimensions.heightPercentage(
                                                                          context,
                                                                          5),
                                                                      width: ScreenDimensions.widthPercentage(
                                                                          context,
                                                                          40),
                                                                      child:
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Text(AppWord.uploadNotificationPicture),
                                                                          SvgPicture.asset(AppImages.upload)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  title: AppWord.transferNotificationPicture,
                                                                  description: AppWord.transferNotificationPictureDetails,
                                                                  card2: const SizedBox.shrink(),
                                                                  onTap: () {
                                                                    Get.back();
                                                                    Future.any([Future.delayed(const Duration(seconds: 2)).then((value) => Get.offAll(const MainScreen(),transition: Transition.fade,duration: const Duration(milliseconds: 700)),), Get.defaultDialog(barrierDismissible: false, title: '', content: BackdropFilter(
                                                                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                                          child: Container(
                                                                            decoration: BoxDecoration(color: CustomColors.gold, borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 1))),
                                                                            width: ScreenDimensions.widthPercentage(context, 80),
                                                                            height: ScreenDimensions.heightPercentage(context, 30),
                                                                            child: Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  size: ScreenDimensions.widthPercentage(context, 10),
                                                                                  Icons.verified,
                                                                                  color: CustomColors.white,
                                                                                ),
                                                                                Text(
                                                                                  AppWord.payingProcessDone,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(fontSize: AppFonts.subTitleFont(context), color: CustomColors.black),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),),]);
                                                                  },
                                                                  buttonName: AppWord.sendTransferNotification,
                                                                  buttonButtonBackground: AppImages.buttonLiteBackground,
                                                                ),
                                                              ),
                                                            ));
                                                      },
                                                      buttonName:
                                                      AppWord
                                                          .continues,
                                                      buttonButtonBackground:
                                                      AppImages
                                                          .buttonLiteBackground,
                                                    ),
                                                  );
                                                }
                                              ),
                                            ));
                                          }
                                              : () {},
                                          buttonButtonBackground: controller.buttonBackground,
                                        );
                                      }),
                                ),
                              ),
                            );
                          },
                          buttonBackground: AppImages.buttonLiteBackground),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 1)),
                  ],
                ).paddingSymmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 5),
                    vertical: ScreenDimensions.heightPercentage(context, 2)),
              ),
            );
          }
        ),
      ),
    );
  }
}
