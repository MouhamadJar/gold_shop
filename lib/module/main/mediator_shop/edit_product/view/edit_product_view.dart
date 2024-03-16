import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/module/invoice/view/invoice_view.dart';
import 'package:gold_shop/module/main/mediator_shop/edit_product/controller/edit_product_controller.dart';
import '../../../../../core/colors/colors.dart';
import '../../../../../core/images/images.dart';
import '../../../../../core/texts/words.dart';
import '../../../../../core/utils/app_fonts.dart';
import '../../../../../core/utils/app_network_image.dart';
import '../../../../../core/utils/dimensions.dart';

class EditProduct extends GetView<EditProductController> {
  const EditProduct({
    super.key,
    required this.productCodeController,
  });

  final String productCodeController ;
  @override
  Widget build(BuildContext context) {
    Get.put(EditProductController());
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
          body: GetBuilder<EditProductController>(
            initState: (state){
              controller.getProductDetails(productCode: productCodeController);
            },
            builder: (_) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator(color: CustomColors.gold,),)
                  : SizedBox(
                width: ScreenDimensions.screenWidth(context),
                height: ScreenDimensions.screenHeight(context),
                child: Column(
                  children: [
                    const PricesBar().paddingOnly(bottom: ScreenDimensions.heightPercentage(context, 3)),
                    controller.isBannersEmpty? const SizedBox.shrink():AdvertisementBanner(
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
                            child: Text(
                              controller.subcategoriesADVS[index].paragraph,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppFonts.smallTitleFont(context)),
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
                            GestureDetector(
                              onTap: () {
                                Get.dialog(BackdropFilter(
                                  filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                                  child: InteractiveViewer(
                                      child:
                                          AppNetworkImage( baseUrlImages + controller.editProductModel!.images.first['image'])),
                                ));
                              },
                              child: Container(
                                padding: EdgeInsetsDirectional.symmetric(
                                  vertical: ScreenDimensions.heightPercentage(context, 2),
                                ),
                                width: ScreenDimensions.screenWidth(context),
                                height: ScreenDimensions.heightPercentage(context, 25),
                                child: AppNetworkImage(baseUrlImages + controller.editProductModel!.images.first['image']),
                              ),
                            ),
                            SizedBox(
                              height: ScreenDimensions.heightPercentage(context, 10),
                              child:  ProductImages(image:  controller.editProductModel!.images,
                                itemCount: controller.editProductModel!.images.length,
                              ),
                            ),
                            Directions(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        controller.editProductModel!.carat,
                                        style: TextStyle(
                                            fontSize: AppFonts.subTitleFont(context)),
                                      ),
                                      Text(
                                        ' ${AppWord.caliber} ',
                                        style: TextStyle(
                                            fontSize: AppFonts.subTitleFont(context)),
                                      ),
                                      Text(
                                        AppWord.productName,
                                        style: TextStyle(
                                            fontSize: AppFonts.subTitleFont(context)),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    controller.editProductModel!.description,
                                    style: TextStyle(
                                        fontSize:
                                            AppFonts.smallTitleFont(context)),
                                  ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
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
                                      details: controller.manufacturer,
                                      onTap: () {
                                        Get.dialog(Material(
                                          color: Colors.transparent,
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                                        context, 70)),
                                                padding: EdgeInsetsDirectional.all(
                                                    ScreenDimensions.widthPercentage(
                                                        context, 5)),
                                                child: Column(
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
                                                    AppTextField(
                                                      title:AppWord.editManufacturer,
                                                      keyboardType: TextInputType.text,
                                                      maxLines: 2,
                                                      controller:  controller.manufacturerController,
                                                      onChanged: (value){
                                                        controller.manufacturerController.text = value;
                                                        controller.manufacturer = controller.manufacturerController.text;
                                                        if (controller.manufacturerController.text.isEmpty || controller.manufacturerController.text == ''){
                                                          controller.manufacturer = controller.editProductModel!.manufacturer;
                                                          controller.update();
                                                        }
                                                        controller.update();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                            ),
                                          ),
                                        ));
                                      },
                                      isRequired: true,
                                      title: AppWord.manufacturer,
                                      picPath: AppImages.building),
                                  Details(
                                      details: controller.editProductModel!.age,
                                      title: AppWord.age,
                                      picPath: AppImages.age),
                                  Details(
                                      details: controller.weight.toString(),
                                      isRequired: true,
                                      onTap: () {
                                        Get.dialog(Material(
                                          color: Colors.transparent,
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                                      context, 70)),
                                              padding: EdgeInsetsDirectional.all(
                                                  ScreenDimensions.widthPercentage(
                                                      context, 5)),
                                              child: Column(
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
                                                  AppTextField(
                                                    title:AppWord.editWeight,
                                                    keyboardType: TextInputType.number,
                                                    maxLines: 2,
                                                    controller:  controller.weightController,
                                                    onChanged: (value){
                                                      controller.weightController.text = value;
                                                      controller.weight = double.parse(controller.weightController.text);
                                                      if (controller.weightController.text.isEmpty || controller.weightController.text == ''){
                                                        controller.weight = controller.editProductModel!.weight;
                                                        controller.update();
                                                      }
                                                      controller.update();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                        },
                                      title: AppWord.weight,
                                      picPath: AppImages.weightScale),
                                  Details(
                                      details: controller.editProductModel!.currentGoldPrice.toString(),
                                      title: AppWord.gramPrice,
                                      picPath: AppImages.priceTag),
                                  Details(
                                      details: controller.editProductModel!.price.toString(),
                                      title: AppWord.productPrice,
                                      picPath: AppImages.priceTag),
                                  Details(
                                      details: controller.carat,
                                      isRequired: true,
                                      onTap: () {
                                        Get.dialog(Material(
                                          color: Colors.transparent,
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                                      context, 70)),
                                              padding: EdgeInsetsDirectional.all(
                                                  ScreenDimensions.widthPercentage(
                                                      context, 5)),
                                              child: Column(
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
                                                  AppTextField(
                                                    title:AppWord.editCarat,
                                                    keyboardType: TextInputType.text,
                                                    maxLines: 2,
                                                    controller:  controller.caratController,
                                                    hintText: '_k',
                                                    onChanged: (value){
                                                      controller.caratController.text = value;
                                                      controller.carat = controller.caratController.text;
                                                      if (controller.caratController.text.isEmpty || controller.caratController.text == ''){
                                                        controller.carat = controller.editProductModel!.carat;
                                                        controller.update();
                                                      }
                                                      controller.update();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                        },
                                      title: AppWord.productCalibre,
                                      picPath: AppImages.scale),
                                  SizedBox(
                                    height: ScreenDimensions.heightPercentage(
                                        context, 2),
                                  ),
                                  Details(
                                    title: AppWord.vendorName,
                                    picPath: '',
                                    details: '${controller.editProductModel!.sellerFirstName} ${controller.editProductModel!.sellerLastName}',
                                    withIcon: false,
                                  ),
                                  Details(
                                    title: AppWord.buyerName,
                                    picPath: '',
                                    details: '${controller.editProductModel!.buyerFirstName} ${controller.editProductModel!.buyerLastName}',
                                    withIcon: false,
                                  ),
                                ],
                              ),
                            ).paddingSymmetric(
                                horizontal: ScreenDimensions.widthPercentage(context, 5),
                              vertical: ScreenDimensions.heightPercentage(context, 1)),
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
                                  controller: controller.noteController,
                                )
                              ],
                            ).paddingSymmetric(
                                horizontal: ScreenDimensions.widthPercentage(context, 5),
                                vertical: ScreenDimensions.heightPercentage(context, 3)),
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
                                horizontal: ScreenDimensions.widthPercentage(context, 10)),
                            AppButton(
                              onTap: () {
                                Get.dialog(
                                    Material(
                                  color: Colors.transparent,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                                    context, 60)),
                                        padding: EdgeInsetsDirectional.all(
                                            ScreenDimensions.widthPercentage(
                                                context, 5)),
                                        child: Column(
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
                                                  onTap: (){
                                                    Get.back();
                                                    controller.sendReport();
                                                  },
                                                  child: Text(AppWord.yes,
                                                      style: TextStyle(
                                                          fontSize:
                                                          AppFonts.smallTitleFont(context),
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                ),
                                              ),
                                              Container(
                                                alignment: AlignmentDirectional.center,
                                                width: ScreenDimensions.widthPercentage(context, 6),
                                                height: ScreenDimensions.widthPercentage(context, 6),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    Get.back();
                                                    },
                                                  child: Text(AppWord.no,
                                                      style: TextStyle(
                                                          fontSize:
                                                          AppFonts.smallTitleFont(
                                                              context),
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                ),
                                              ),
                                            ],).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 4)),
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
              );
            }
          ),
        ),
      ),
    );
  }
}
