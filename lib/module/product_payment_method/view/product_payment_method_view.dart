import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/privacy/view/privacy_view.dart';
import 'package:gold_shop/module/product_payment_method/controller/product_payment_method_controller.dart';

class ProductPaymentMethod extends GetView<ProductPaymentMethodController> {
   const ProductPaymentMethod({
    super.key,
    required this.images,
    required this.descriptionController,
    required this.weightController,
    required this.subcategoryId,
    required this.caliber,
    required this.profitController,
    required this.caliberPriceValue,
     this.additionController,
     this.additionDescriptionController,
    required this.manufacturerController,
     required this.productType,
     required this.toggle,
     this.addressId,
     // required this.discountToggle,
     // this.discountDescriptionController,
     // this.discountValueController,
  });
  final List<File> images;
  final TextEditingController descriptionController;
  final TextEditingController weightController;
  final int subcategoryId;
  final String caliber;
  final TextEditingController profitController;
  final double caliberPriceValue;
  final TextEditingController? additionController;
  final TextEditingController? additionDescriptionController;
  final TextEditingController manufacturerController;
  final int productType;
  final int toggle;
  final int? addressId;
  // final bool discountToggle ;
  // final TextEditingController? discountDescriptionController;
  // final TextEditingController? discountValueController;
  @override
  Widget build(BuildContext context) {
    List<String> phoneNumber = [];
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
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppWord.chooseYourLocation,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context) + 5,
                          fontWeight: FontWeight.bold),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppPopUpMenu(
                            title: controller.selectedCountry,
                            items: controller.countries.map((e) => PopupMenuItem(
                              value: e,
                                onTap: (){
                                controller.selectedCountry=e;
                                controller.getCities(country: e);
                                controller.update();
                                },
                                child: Text(
                                    e,
                                  style: TextStyle(fontSize: AppFonts.smallTitleFont(context),
                                  ),
                                ),),).toList(),),
                        AppPopUpMenu(
                            title: controller.selectedCity,
                            items: controller.cities.map((e) => PopupMenuItem(
                              value: e.city,
                                onTap: (){
                                controller.selectedCity=e.city;
                                controller.addressId = e.addressId;
                                controller.update();
                                },
                                child: Text(
                                    e.city,
                                  style: TextStyle(fontSize: AppFonts.smallTitleFont(context),
                                  ),
                                ),),).toList(),),
                      ],
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
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
                              controller.inPerson = value!;
                              controller.withMediatorShop = false;
                              controller.selectedStoreId =null;
                              controller.selectedStore = null;
                              controller.inPerson?controller.deliveryMethod=1:controller.deliveryMethod=null;
                              controller.update();
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
                        SizedBox(
                          width: ScreenDimensions.widthPercentage(context, 70),
                          child: Text(
                            AppWord.withMediatorShop,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: AppFonts.smallTitleFont(context),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GetBuilder<ProductPaymentMethodController>(builder: (_) {
                          return Checkbox(
                            value: controller.withMediatorShop,
                            onChanged: (value) {
                              controller.withMediatorShop = value!;
                              controller.inPerson = false;
                              controller.withMediatorShop?controller.deliveryMethod=2:controller.deliveryMethod =null;
                              controller.update();
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
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Text(
                              //       AppWord.mediatorShopBetweenVendorAndBuyer,
                              //       style: TextStyle(
                              //           fontSize:
                              //               AppFonts.smallTitleFont(context),
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     GetBuilder<ProductPaymentMethodController>(
                              //         builder: (_) {
                              //       return Checkbox(
                              //         value: controller.mediatorShopBetween,
                              //         onChanged: (value) {
                              //           controller.mediatorShopBetween = value!;
                              //           controller.mediatorShopFromPlatform = false;
                              //           controller.update();
                              //         },
                              //         activeColor: CustomColors.gold,
                              //       );
                              //     })
                              //   ],
                              // ).paddingSymmetric(
                              //     vertical: ScreenDimensions.heightPercentage(context, 2)),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Text(
                              //       AppWord.mediatorShopFromPlatform,
                              //       style: TextStyle(
                              //           fontSize:
                              //               AppFonts.smallTitleFont(context),
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     GetBuilder<ProductPaymentMethodController>(
                              //         builder: (_) {
                              //       return Checkbox(
                              //         value: controller.mediatorShopFromPlatform,
                              //         onChanged: (value) {
                              //           controller.mediatorShopFromPlatform = value!;
                              //           controller.mediatorShopBetween = false;
                              //           controller.update();
                              //         },
                              //         activeColor: CustomColors.gold,
                              //       );
                              //     }),
                              //   ],
                              // ).paddingSymmetric(
                              //     vertical: ScreenDimensions.heightPercentage(context, 2)),
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
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceEvenly,
                                    //   children: [
                                    //     AppPopUpMenu(
                                    //         title: AppWord.chooseNeighborhood,
                                    //         items: [],
                                    //         onSelected: (value) {}),
                                    //     AppPopUpMenu(
                                    //         title: AppWord.chooseCity,
                                    //         items: [],
                                    //         onSelected: (value) {}),
                                    //   ],
                                    // ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceEvenly,
                                    //   children: [
                                    //     SizedBox(
                                    //       width: ScreenDimensions.widthPercentage(
                                    //           context, 15),
                                    //       height:
                                    //           ScreenDimensions.heightPercentage(
                                    //               context, 4),
                                    //       child: AppButton(
                                    //           text: Text(
                                    //             AppWord.search,
                                    //             style: TextStyle(
                                    //                 color: CustomColors.white,
                                    //                 fontWeight: FontWeight.bold),
                                    //           ),
                                    //           onTap: () {},
                                    //           buttonBackground:
                                    //               AppImages.buttonLiteBackground),
                                    //     ),
                                    //     SizedBox(
                                    //       width: ScreenDimensions.widthPercentage(
                                    //           context, 20),
                                    //       height:
                                    //           ScreenDimensions.heightPercentage(
                                    //               context, 3),
                                    //       child: TextFormField(
                                    //         decoration: InputDecoration(
                                    //             border:
                                    //                 const OutlineInputBorder(),
                                    //             focusedBorder: OutlineInputBorder(
                                    //                 borderSide: BorderSide(
                                    //                     color:
                                    //                         CustomColors.gold))),
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       AppWord.to,
                                    //       style: TextStyle(
                                    //         fontSize:
                                    //             AppFonts.smallTitleFont(context),
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: ScreenDimensions.widthPercentage(
                                    //           context, 20),
                                    //       height:
                                    //           ScreenDimensions.heightPercentage(
                                    //               context, 3),
                                    //       child: TextFormField(
                                    //         decoration: InputDecoration(
                                    //             border:
                                    //                 const OutlineInputBorder(),
                                    //             focusedBorder: OutlineInputBorder(
                                    //                 borderSide: BorderSide(
                                    //                     color:
                                    //                         CustomColors.gold))),
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       AppWord.from,
                                    //       style: TextStyle(
                                    //         fontSize:
                                    //             AppFonts.smallTitleFont(context),
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       AppWord.platformProfit,
                                    //       style: TextStyle(
                                    //         fontSize:
                                    //             AppFonts.smallTitleFont(context),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                    // SizedBox(
                                    //   width: ScreenDimensions.widthPercentage(
                                    //       context, 30),
                                    //   height: ScreenDimensions.heightPercentage(
                                    //       context, 4),
                                    //   child: TextFormField(
                                    //     textAlign: TextAlign.right,
                                    //     decoration: InputDecoration(
                                    //         hintText: AppWord.searchForMediatorShopName,
                                    //         hintStyle: TextStyle(fontSize: AppFonts.smallTitleFont(context)),
                                    //         border: const OutlineInputBorder(),
                                    //         focusedBorder: OutlineInputBorder(
                                    //             borderSide: BorderSide(
                                    //                 color: CustomColors.gold))),
                                    //   ),
                                    // ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                    Container(
                                      width: ScreenDimensions.screenWidth(context),
                                      height: ScreenDimensions.heightPercentage(context, 25),
                                      margin: EdgeInsets.all(ScreenDimensions.widthPercentage(context, 1)),
                                      child: ListView.builder(
                                        itemCount: controller.storesModel.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: (){
                                              Get.dialog(
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: BackdropFilter(
                                                        filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                                        child: Container(
                                                            margin: EdgeInsets.symmetric(vertical: ScreenDimensions.heightPercentage(context, 30),horizontal: ScreenDimensions.widthPercentage(context, 10)),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 1),),
                                                            color: CustomColors.white,
                                                          ),
                                                          child: Column(
                                                              children: [
                                                                Text(
                                                                  AppWord.warning,
                                                                  style: TextStyle(
                                                                      fontSize: AppFonts.subTitleFont(context),
                                                                      fontWeight: FontWeight.bold,
                                                                    color: CustomColors.black,
                                                                  ),).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                                                Icon(Icons.warning,color: CustomColors.red,size: ScreenDimensions.widthPercentage(context, 13),),
                                                                Text(
                                                                  AppWord.chooseTheMediatorCarefully,
                                                                  style: TextStyle(
                                                                    fontSize: AppFonts.smallTitleFont(context),
                                                                    fontWeight: FontWeight.bold,
                                                                    color: CustomColors.black,
                                                                  ),).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                                                const Spacer(),
                                                                Center(
                                                                  child: AppButton(
                                                                    text: Text(
                                                                    AppWord.cancel,
                                                                    style: TextStyle(
                                                                      fontSize: AppFonts.smallTitleFont(context),
                                                                      fontWeight: FontWeight.bold,
                                                                      color: CustomColors.white,
                                                                    ),), onTap: (){
                                                                      Get.back();
                                                                  }, buttonBackground: AppImages.buttonDarkBackground).marginSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 20)),
                                                                ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                                                Center(
                                                                  child: AppButton(
                                                                    text: Text(
                                                                    AppWord.choose,
                                                                    style: TextStyle(
                                                                      fontSize: AppFonts.smallTitleFont(context),
                                                                      fontWeight: FontWeight.bold,
                                                                      color: CustomColors.white,
                                                                    ),),
                                                                      onTap: (){
                                                                        controller.selectedStoreId = controller.storesModel[index].id;
                                                                        controller.selectedStore = index;
                                                                        controller.update();
                                                                        Get.back();
                                                                        WarningSnackBar.warningSnackBar(context, AppWord.done);
                                                                      },
                                                                      buttonBackground: AppImages.buttonLiteBackground).marginSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 20)),
                                                                ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                                                              ],
                                                          ),
                                                        ),
                                                    ),
                                                  ),
                                              );
                                            },
                                            child: Container(
                                              width: ScreenDimensions.widthPercentage(context, 50),
                                              height: ScreenDimensions.heightPercentage(context, 15),
                                              margin: EdgeInsets.all(ScreenDimensions.widthPercentage(context, 2)),
                                              decoration: BoxDecoration(
                                                  color: CustomColors.silver,
                                                  border: controller.selectedStore==index?Border.all(
                                                      width: ScreenDimensions.widthPercentage(
                                                          context, 1),
                                                      color: CustomColors.black):Border.all(
                                                      width: ScreenDimensions.widthPercentage(
                                                          context, 0.5),
                                                      color: CustomColors.gold),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        controller.storesModel[index].name,
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
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: AppFonts
                                                                      .smallTitleFont(
                                                                      context)),
                                                              children: [
                                                                TextSpan(
                                                                    text: '${AppWord.checkingService} '),
                                                                 TextSpan(
                                                                    text: controller.storesModel[index].cost.toString()),
                                                                TextSpan(
                                                                    text: ' ${AppWord.sad}'),
                                                              ])),
                                                      SizedBox(
                                                        width: ScreenDimensions.widthPercentage(context, 90),
                                                        child: Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              TextSpan(text: ' ${controller.storesModel[index].country} '),
                                                              TextSpan(text: ' ${controller.storesModel[index].state} '),
                                                              TextSpan(text: ' ${controller.storesModel[index].city} '),
                                                              TextSpan(text: ' ${controller.storesModel[index].neighborhood} '),
                                                              TextSpan(text: ' ${controller.storesModel[index].street} '),
                                                            ],),
                                                          maxLines: 2,textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: AppFonts.smallTitleFont(context)),
                                                        ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 1)),
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                      right: 0,
                                                      bottom: 0,
                                                      child: controller.selectedStore==index?Icon(Icons.verified,color: CustomColors.black,):const SizedBox.shrink())
                                                ],
                                              ),
                                            ),
                                          ) ;
                                        },
                                      ),
                                    ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                                  ],
                                ),
                              ).paddingSymmetric(
                                  vertical: ScreenDimensions.heightPercentage(
                                      context, 2)),
                            ],
                          ).paddingSymmetric(
                            vertical: ScreenDimensions.heightPercentage(context, 2))
                        : const SizedBox.shrink(),
                    Text(
                      AppWord.phoneNumber,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: AppFonts.smallTitleFont(context) + 5,
                          fontWeight: FontWeight.bold),
                    ),
                     AppTextField(
                            title: '',
                       keyboardType: TextInputType.phone,
                       controller: controller.firstPhoneNumberController,
                       hintText: '05********',
                       onChanged: (value){
                              controller.firstPhoneNumberController.text = value;
                              controller.update();
                              },
                       validator: (value){{
                         phoneNumber = value.toString().characters.toList();
                         if (value.toString().isEmpty||value==null){
                           return AppWord.empty;
                         }if(value.toString().length!=10){
                           return AppWord.only10Characters;
                         }
                         if(phoneNumber[0]!='0'||phoneNumber[1]!='5'){
                           WarningSnackBar.warningSnackBar(context, AppWord.mustStartWith05);
                           return AppWord.mustStartWith05;
                         }
                         return null ;
                       }
                       },
                     ),
                    // controller.phoneNumberCount>=2
                    //     ?DelayedDisplay(
                    //       child: AppTextField(
                    //         title: '',
                    //         keyboardType: TextInputType.phone,
                    //         controller: controller.secondPhoneNumberController,
                    //         onChanged: (value){
                    //       controller.secondPhoneNumberController!.text = value;
                    //       controller.update();
                    //                           },
                    //         validator: (value){
                    //           if(controller.secondPhoneNumberController!=null){
                    //           return AppValidator().phoneValidator(value);
                    //           }
                    //           return null;
                    //         },
                    //       ).paddingSymmetric(
                    //         vertical: ScreenDimensions.heightPercentage(context, 2)),
                    //     )
                    //     :const SizedBox.shrink(),
                    // controller.phoneNumberCount == 3
                    //     ?DelayedDisplay(
                    //       child: AppTextField(
                    //         title: '',
                    //         keyboardType: TextInputType.phone,
                    //         controller: controller.thirdPhoneNumberController,
                    //         onChanged: (value){
                    //       controller.thirdPhoneNumberController!.text = value;
                    //       controller.update();
                    //                           },
                    //         validator: (value){
                    //           if(controller.thirdPhoneNumberController!= null){
                    //           return AppValidator().phoneValidator(value);
                    //           }
                    //           return null;
                    //         },
                    //       ).paddingSymmetric(
                    //       vertical: ScreenDimensions.heightPercentage(context, 2)),
                    //     )
                    //     :const SizedBox.shrink(),
                    // Align(
                    //   alignment: AlignmentDirectional.topStart,
                    //   child: Row(
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           controller.removePhoneNumber();
                    //         },
                    //         child: Container(
                    //           width: ScreenDimensions.widthPercentage(context, 10),
                    //           height: ScreenDimensions.heightPercentage(context, 5),
                    //           decoration: BoxDecoration(
                    //             boxShadow: [
                    //               BoxShadow(
                    //                   color: CustomColors.shadow,
                    //                   spreadRadius: 0.1,
                    //                   blurStyle: BlurStyle.outer,
                    //                   blurRadius: 3)
                    //             ],
                    //             color: CustomColors.gold,
                    //           ),
                    //           child: Icon(
                    //             Icons.remove,
                    //             size: ScreenDimensions.widthPercentage(context, 7),
                    //             color: CustomColors.white,
                    //           ),
                    //         ),
                    //       ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 5)),
                    //       GestureDetector(
                    //         onTap: () {controller.addPhoneNumber();},
                    //         child: Container(
                    //           width: ScreenDimensions.widthPercentage(context, 10),
                    //           height: ScreenDimensions.heightPercentage(context, 5),
                    //           decoration: BoxDecoration(
                    //             boxShadow: [
                    //               BoxShadow(
                    //                   color: CustomColors.shadow,
                    //                   spreadRadius: 0.1,
                    //                   blurStyle: BlurStyle.outer,
                    //                   blurRadius: 3)
                    //             ],
                    //             color: CustomColors.gold,
                    //           ),
                    //           child: Icon(
                    //             Icons.add,
                    //             size: ScreenDimensions.widthPercentage(context, 7),
                    //             color: CustomColors.white,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ).paddingSymmetric(
                    //   vertical: ScreenDimensions.heightPercentage(context, 2),),
                    // Text(
                    //   AppWord.thosePhoneNumbersWillBeHandled,
                    //   textAlign: TextAlign.right,
                    //   style: TextStyle(
                    //       fontSize: AppFonts.smallTitleFont(context),
                    //       fontWeight: FontWeight.bold),
                    // ).paddingSymmetric(
                    //     vertical: ScreenDimensions.heightPercentage(context, 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      TextButton(
                        onPressed: (){
                          Get.to(const Privacy(),transition: Transition.downToUp,duration: const Duration(milliseconds: 500));
                        },
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
                              controller.privacyCheck= value!;
                              controller.update();
                            },activeColor: CustomColors.gold);
                          }
                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
                    ],),
                    controller.privacyCheck==true?Center(
                      child: AppButton(
                          text: Text(
                            AppWord.addThisProduct,
                            style: TextStyle(
                                color: CustomColors.white,
                                fontSize: AppFonts.smallTitleFont(context),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            if(!(controller.formKey.currentState!.validate())){
                              return;
                            }
                            if(controller.deliveryMethod == null){
                              WarningSnackBar.warningSnackBar(context, AppWord.chooseDeliverMethod);
                              return;
                            }if(controller.addressId==null){
                              WarningSnackBar.warningSnackBar(context, AppWord.chooseYourLocation);
                              return;
                            }
                            if(controller.withMediatorShop&&controller.selectedStoreId==null){
                              WarningSnackBar.warningSnackBar(context, AppWord.chooseMediatorShop);
                              return;
                            }
                            else{
                              Get.dialog(
                                WillPopScope(onWillPop: ()async{return false;}, child: Center(child: CircularProgressIndicator(color: CustomColors.gold,),)),barrierDismissible: false,);
                            controller.addProduct(
                                images: images,
                                descriptionController: descriptionController.text,
                                weightController: double.parse(weightController.text),
                                carat: caliber,
                                productType: productType,
                                subcategoryId: subcategoryId,
                                currentGoldPriceController:caliberPriceValue,
                                profitController: double.parse(profitController.text),
                                additionController: double.parse(profitController.text),
                                additionDescriptionController: additionDescriptionController!.text,
                                manufacturerController: manufacturerController.text,
                                toggle: toggle,
                              // discountToggle: discountToggle==true?1:0,
                                // discountValueController: double.parse(discountValueController!.text),
                                // offerDescriptionController: discountDescriptionController!.text,
                            );}
                              controller.update();

                          },
                          buttonBackground: AppImages.buttonLiteBackground),
                    ):Center(
                      child: AppButton(
                          text: Text(
                            AppWord.addThisProduct,
                            style: TextStyle(
                                color: CustomColors.white,
                                fontSize: AppFonts.smallTitleFont(context),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                          buttonBackground: AppImages.buttonDarkBackground),
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 4),
                    vertical: ScreenDimensions.heightPercentage(context, 2)),
              ),
            ),
          ),
        ),
      );
    });
  }
}
