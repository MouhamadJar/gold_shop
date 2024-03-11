import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/maps.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';
import 'package:gold_shop/module/buy_order/controller/buy_order_controller.dart';
import '../../../core/colors/colors.dart';
import '../../../core/components/components.dart';
import '../../../core/components/problem_dialog.dart';
import '../../../core/images/images.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';

class BuyOrder extends GetView<BuyOrderController> {
  const BuyOrder({super.key, this.orderId =1});
 final int orderId;
  @override
  Widget build(BuildContext context) {
    Get.put(BuyOrderController());
    return SafeArea(
      child: Directions(
        child: Scaffold(
          backgroundColor: CustomColors.white,
          appBar: AppBar(
            backgroundColor: CustomColors.white,
            elevation: 1,
            centerTitle: true,
            title: Text(
              AppWord.buyOrder,
              style: TextStyle(
                  fontSize: AppFonts.subTitleFont(context),
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: GetBuilder<BuyOrderController>(
            initState: (state){
              controller.getBuyOrder(orderId: orderId);
            },
            builder: (_) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator(color: CustomColors.gold,),)
                  : SizedBox(
                width: ScreenDimensions.screenWidth(context),
                height: ScreenDimensions.screenHeight(context),
                child: Directions(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: '${controller.buyOrderModel!.buyerFirstName} ${controller.buyOrderModel!.buyerLastName}'),
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
                              TextSpan(text: controller.buyOrderModel!.productPrice.toString()),
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
                          AppWord.vendorInfo,
                          style: TextStyle(
                              shadows: [
                                Shadow(blurRadius: 3, color: CustomColors.shadow)
                              ],
                              color: CustomColors.yellow,
                              fontSize: AppFonts.subTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ).paddingSymmetric(
                            vertical: ScreenDimensions.heightPercentage(context, 3)),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: '${controller.buyOrderModel!.sellerFirstName} ${controller.buyOrderModel!.sellerLastName}'),
                              const TextSpan(text: ' : '),
                              TextSpan(text: AppWord.vendorName),
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
                              TextSpan(text: controller.buyOrderModel!.sellerPhoneNumber),
                              const TextSpan(text: ' : '),
                              TextSpan(text: AppWord.vendorNumber),
                            ],
                            style: TextStyle(
                                color: CustomColors.black,
                                fontSize: AppFonts.smallTitleFont(context),
                                fontWeight: FontWeight.bold),
                          ),
                        ).paddingSymmetric(
                            vertical: ScreenDimensions.heightPercentage(context, 1)),
                        Text(
                          AppWord.address,
                          style: TextStyle(
                              shadows: [
                                Shadow(blurRadius: 3, color: CustomColors.shadow)
                              ],
                              color: CustomColors.yellow,
                              fontSize: AppFonts.subTitleFont(context),
                              fontWeight: FontWeight.bold),
                        ).paddingSymmetric(
                            vertical: ScreenDimensions.heightPercentage(context, 3)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: ScreenDimensions.widthPercentage(context, 80),
                              child: Text(
                                '${controller.buyOrderModel!.country} , ${controller.buyOrderModel!.state} , ${controller.buyOrderModel!.city} , ${controller.buyOrderModel!.neighborhood} , ${controller.buyOrderModel!.street}',
                                maxLines: 3,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFonts.smallTitleFont(context)),
                              ),
                            ),
                            SvgPicture.asset(
                              AppImages.location,
                            ),
                          ],
                        ),
                        AppGoogleMap(markers: {controller.marker!},cameraPosition: controller.position).paddingSymmetric(
                            vertical: ScreenDimensions.heightPercentage(
                                context, 2)),
                        // Container(
                        //   width: ScreenDimensions.screenWidth(context),
                        //   height: ScreenDimensions.heightPercentage(context, 15),
                        //   decoration: BoxDecoration(border: Border.all()),
                        // ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                        SizedBox(
                          width: ScreenDimensions.widthPercentage(context, 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsetsDirectional.all(
                                      ScreenDimensions.widthPercentage(context, 4)),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        color: CustomColors.shadow,
                                        blurStyle: BlurStyle.outer,
                                        spreadRadius: 1)
                                  ]),
                                  child: SvgPicture.asset(AppImages.whatsApp)),
                              Text(
                                AppWord.shareAddress,
                                style: TextStyle(
                                    color: CustomColors.black,
                                    fontSize: AppFonts.smallTitleFont(context)),
                              ),
                            ],
                          ),
                        ),
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
                                    vertical:
                                        ScreenDimensions.heightPercentage(context, 2),
                                    horizontal:
                                        ScreenDimensions.widthPercentage(context, 2)),
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
                                                    fontSize: AppFonts.smallTitleFont(context)),
                                                children: [
                                                  TextSpan(
                                                      text: ' ${AppWord.productCalibre}',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.bold)),
                                                  TextSpan(
                                                      text: controller.buyOrderModel!.carat.toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            Text(
                                                 controller.buyOrderModel!.description,
                                                maxLines: 6,
                                                style:  TextStyle(
                                                  color: CustomColors.black,
                                                  fontSize: AppFonts.smallTitleFont(context),
                                                  overflow: TextOverflow.ellipsis,
                                                )),
                                          ],
                                        ),
                                      ),
                                      AppNetworkImage(
                                        baseUrlImages + controller.buyOrderModel!.images[0]['image'],
                                      width: ScreenDimensions.widthPercentage(context, 20 ),
                                      height: ScreenDimensions.heightPercentage(context, 15 ),
                                      ),
                                    ],
                                  ),
                                ))
                            .paddingSymmetric(
                                vertical:
                                    ScreenDimensions.heightPercentage(context, 3)),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: controller.buyOrderModel!.orderCode.toString()),
                              const TextSpan(text: ' : '),
                              TextSpan(text: AppWord.payingProcessConfirmationCode),
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
                              title: AppWord.shareProduct,
                              picPath: AppImages.share,
                              onTap: () {
                                Get.dialog(
                                  Directions(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                                        child: Container(
                                          margin: EdgeInsetsDirectional.only(
                                              top: ScreenDimensions.heightPercentage(
                                                  context, 5),
                                              bottom:
                                                  ScreenDimensions.heightPercentage(
                                                      context, 70),
                                              start: ScreenDimensions.widthPercentage(
                                                  context, 5),
                                              end: ScreenDimensions.widthPercentage(
                                                  context, 5)),
                                          padding: EdgeInsetsDirectional.all(
                                              ScreenDimensions.widthPercentage(
                                                  context, 3)),
                                          color: CustomColors.white,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: SvgPicture.asset(
                                                          AppImages.x,
                                                          width: ScreenDimensions
                                                              .widthPercentage(
                                                                  context, 3))),
                                                  Text(AppWord.shareProduct,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: AppFonts.smallTitleFont(context))),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.center ,
                                                child: Container(
                                                    padding: EdgeInsetsDirectional.all(
                                                            ScreenDimensions
                                                                .widthPercentage(
                                                                    context, 4)),
                                                    decoration: BoxDecoration(boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 5,
                                                          color:
                                                              CustomColors.shadow,
                                                          blurStyle:
                                                              BlurStyle.outer,
                                                          spreadRadius: 1)
                                                    ]),
                                                    child: SvgPicture.asset(
                                                        AppImages.whatsApp)).paddingSymmetric(
                                                    vertical: ScreenDimensions
                                                        .heightPercentage(context, 5)),
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
                              title: AppWord.reportProblem,
                              picPath: AppImages.report,
                              onTap: () {
                                showProblemDialog(context: context, productId: controller.buyOrderModel!.productId);
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
                                  style: TextStyle(
                                      color: CustomColors.white,
                                      fontSize: AppFonts.smallTitleFont(context))),
                              onTap: () {
                                Get.back();
                              },
                              buttonBackground: AppImages.buttonDarkBackground),
                        ).paddingSymmetric(
                            vertical: ScreenDimensions.heightPercentage(context, 1)),
                      ],
                    ).paddingSymmetric(
                        horizontal: ScreenDimensions.widthPercentage(context, 5),
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
