import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/location_service/location_entity.dart';
import 'package:gold_shop/core/network/dio_helper.dart';
import 'package:gold_shop/core/utils/app_network_image.dart';

import '../colors/colors.dart';
import '../images/images.dart';
import '../texts/words.dart';
import '../utils/app_fonts.dart';
import '../utils/dimensions.dart';

class AdvertisementBanner extends StatelessWidget {
  const AdvertisementBanner({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index, int realIndex)?
      itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Directions(
      child: Container(
        width: ScreenDimensions.screenWidth(context),
        height: ScreenDimensions.heightPercentage(context, 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0, 1],
            colors: [
              CustomColors.black,
              CustomColors.greyDark,
            ],
          ),
        ),
        child: CarouselSlider.builder(
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 8),
          ),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}

class AppPopUpMenu extends StatelessWidget {
  const AppPopUpMenu(
      {super.key,
      required this.title,
      required this.items,
       this.onSelected});

  final String title;
  final List<PopupMenuItem> items;
  final PopupMenuItemSelected? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onSelected,
      elevation: 1,
      color: CustomColors.white,
      itemBuilder: (BuildContext context) {
        return items;
      },
      shape: const LinearBorder(),
      child: Container(
        width: ScreenDimensions.widthPercentage(context, 40),
        height: ScreenDimensions.heightPercentage(context, 5),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(
            ScreenDimensions.widthPercentage(context, 2),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.keyboard_arrow_down_rounded,
                size: ScreenDimensions.heightPercentage(context, 3)),
            Text(
              title,
              maxLines: 1,
              style: TextStyle(
                fontSize: AppFonts.smallTitleFont(context) - 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ).paddingSymmetric(
            horizontal: ScreenDimensions.widthPercentage(context, 2)),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.buttonBackground});

  final Widget text;
  final GestureTapCallback onTap;
  final String buttonBackground;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsetsDirectional.all(
            ScreenDimensions.heightPercentage(context, 1)),
        width: ScreenDimensions.widthPercentage(context, 60),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                ScreenDimensions.widthPercentage(context, 6)),
            image: DecorationImage(
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
                fit: BoxFit.fill,
                image: AssetImage(buttonBackground))),
        child: text,
      ),
    );
  }
}

class Details extends StatelessWidget {
  Details(
      {super.key,
      required this.title,
      this.picPath,
      this.isRequired,
      this.onTap,
      required this.details,
      this.withIcon});

  final String title;
  final String? picPath;
  final String details;

  bool? isRequired = false;
  bool? withIcon = true;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenDimensions.screenWidth(context),
      child: Row(
        children: [
          isRequired == true
              ? GestureDetector(
                  onTap: onTap, child: SvgPicture.asset(AppImages.edit2))
              : const SizedBox.shrink(),
          const Spacer(),
          Text(
            details,
            style: TextStyle(
              fontSize: AppFonts.smallTitleFont(context),
            ),
          ),
          SizedBox(
            width: ScreenDimensions.widthPercentage(context, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  ' : ',
                  style: TextStyle(
                      fontSize: AppFonts.smallTitleFont(context),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppFonts.smallTitleFont(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: ScreenDimensions.widthPercentage(context, 1),
          ),
          withIcon == true
              ? SvgPicture.asset(
                  picPath!,
                  color: CustomColors.black,
                )
              : const SizedBox.shrink(),
        ],
      ).paddingSymmetric(
          vertical: ScreenDimensions.heightPercentage(context, 1)),
    );
  }
}

class ScrollingContainer extends StatelessWidget {
  const ScrollingContainer({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(
          horizontal: ScreenDimensions.widthPercentage(context, 1)),
      width: ScreenDimensions.widthPercentage(context, 3),
      height: ScreenDimensions.heightPercentage(context, 1.5),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: CustomColors.yellow),
          borderRadius: BorderRadius.circular(
              ScreenDimensions.widthPercentage(context, 10))),
    );
  }
}

class ProductImages extends StatelessWidget {
  const ProductImages(
      {super.key, required this.itemCount, this.image = const []});

  final List<dynamic> image;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      padding: EdgeInsetsDirectional.symmetric(
          horizontal: ScreenDimensions.widthPercentage(context, 1),
          vertical: ScreenDimensions.heightPercentage(context, 1)),
      itemBuilder: (context, index) => GestureDetector(
        onTap: (){
          Get.dialog(InteractiveViewer(child: AppNetworkImage(baseUrlImages + image[index]['image'],
              fit: BoxFit.contain),).paddingSymmetric(
            vertical: ScreenDimensions.heightPercentage(context, 20),
            horizontal: ScreenDimensions.widthPercentage(context, 10)),);
        },
        child: Container(
          width: ScreenDimensions.widthPercentage(context, 20),
          decoration: BoxDecoration(
            color: CustomColors.white,
            boxShadow: [
              BoxShadow(
                color: CustomColors.shadow,
                spreadRadius: 1,
                blurRadius: 2,
              )
            ],
          ),
          padding: EdgeInsets.symmetric(vertical:ScreenDimensions.heightPercentage(context, 1),horizontal: ScreenDimensions.widthPercentage(context, 1)),
          child: AppNetworkImage(baseUrlImages + image[index]['image'],
              fit: BoxFit.contain),
        ),
      ).paddingSymmetric(horizontal: ScreenDimensions.widthPercentage(context, 2)),
    );
  }
}

class AppDialog extends StatelessWidget {
  const AppDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.card1,
      this.card2,
      required this.onTap,
      required this.buttonName,
      required this.buttonButtonBackground,
      this.expand =false
      });

  final String title;
  final bool expand;
  final String description;
  final Widget card1;
  final Widget? card2;
  final GestureTapCallback onTap;
  final String buttonName;
  final String buttonButtonBackground;

  @override
  Widget build(BuildContext context) {
    return Directions(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: expand?ScreenDimensions.heightPercentage(context, 14):ScreenDimensions.heightPercentage(context, 25),
              horizontal: ScreenDimensions.widthPercentage(context, 5),
          ),
          padding: EdgeInsetsDirectional.all(
              ScreenDimensions.widthPercentage(context, 5)),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: SvgPicture.asset(AppImages.x,
                        width:
                            ScreenDimensions.widthPercentage(context, 3)),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                              blurRadius: 0.5, color: CustomColors.black)
                        ],
                        color: CustomColors.gold,
                        fontSize: AppFonts.subTitleFont(context)-2,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppFonts.smallTitleFont(context),
                ),
              ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
              Container(
                  alignment: AlignmentDirectional.center,
                  width: ScreenDimensions.widthPercentage(context, 70),
                  child: card1.paddingSymmetric(
                      vertical:
                          ScreenDimensions.heightPercentage(context, 2))),
              Container(
                  width: ScreenDimensions.widthPercentage(context, 70),
                  alignment: AlignmentDirectional.center,
                  child: card2!.paddingSymmetric(
                      vertical:
                          ScreenDimensions.heightPercentage(context, 2))),
              AppButton(
                onTap: onTap,
                text: Text(
                  buttonName,
                  style: TextStyle(
                      color: CustomColors.white,
                      fontSize: AppFonts.smallTitleFont(context),
                      fontWeight: FontWeight.bold),
                ),
                buttonBackground: buttonButtonBackground,
              ).paddingOnly(
                  bottom: ScreenDimensions.heightPercentage(context, 1),
                  top: ScreenDimensions.heightPercentage(context, 5)),
            ],
          ),
        ),
      ),
    );
  }
}

class Directions extends StatelessWidget {
  const Directions({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.locale == const Locale('ar')
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: child,
    );
  }
}

class FloatingContainer extends StatelessWidget {
  const FloatingContainer(
      {super.key,
      required this.title,
      required this.picPath,
      required this.onTap});

  final String title;

  final String picPath;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: AlignmentDirectional.center,
            width: ScreenDimensions.widthPercentage(context, 18),
            height: ScreenDimensions.heightPercentage(context, 8),
            decoration: BoxDecoration(
                color: CustomColors.white,
                boxShadow: [
                  BoxShadow(
                      color: CustomColors.grey,
                      blurStyle: BlurStyle.outer,
                      blurRadius: 5,
                      offset: const Offset(0, 3)),
                ],
                borderRadius:
                    BorderRadius.circular(ScreenDimensions.radius(context, 5))),
            padding: EdgeInsetsDirectional.all(
                ScreenDimensions.widthPercentage(context, 2)),
            child: SvgPicture.asset(
              picPath,
              height: ScreenDimensions.heightPercentage(context, 4.5),
            ),
          ),
        ),
        SizedBox(
          height: ScreenDimensions.heightPercentage(context, 1),
        ),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.black,
              fontSize: AppFonts.smallTitleFont(context)),
        )
      ],
    );
  }
}

class AppTextField extends StatelessWidget {
   AppTextField({
    super.key,
    this.title,
    this.hintText,
     this.keyboardType,
    this.label,
    this.controller,
    this.enabled,
    this.prefix,
    this.suffix,
    this.suffixIconColor,
    this.prefixIconColor,
    this.maxLines,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.obscureText = false,
  });
  final String? title;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? label;
  final TextEditingController? controller;
  final bool? enabled;
  final Widget? suffix;
  final MaterialColor? suffixIconColor;
  final MaterialColor? prefixIconColor;
  final Widget? prefix;
  final int? maxLines;
  final FormFieldValidator? validator;
  final void Function(String)? onChanged;
  final String? initialValue;
   bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Directions(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (title != null)
            Text(
              title!,
              style: TextStyle(
                fontSize: AppFonts.smallTitleFont(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          SizedBox(
            height: ScreenDimensions.heightPercentage(context, 2),
          ),
          TextFormField(
            onChanged:onChanged ,
            obscureText: obscureText,
            initialValue: initialValue,
            validator: validator,
            maxLines: maxLines,
            enabled: enabled,
            controller: controller,
            textAlign: TextAlign.center,
            cursorColor: CustomColors.gold,
            style: TextStyle(
              fontSize: AppFonts.smallTitleFont(context),
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText:hintText ,
              label: label,
              suffixIcon: suffix,
              suffixIconColor: suffixIconColor ?? CustomColors.black,
              prefixIcon: prefix,
              prefixIconColor: prefixIconColor ?? CustomColors.black,
              floatingLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppFonts.smallTitleFont(context),
                  color: CustomColors.gold),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.gold)),
            ),
          ),
        ],
      ),
    );
  }
}

class BackArrow extends StatelessWidget {
  const BackArrow({
    super.key,
    this.color
  });
 final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.back();
        },
        child:  Icon(Icons.arrow_back,color: color,));
  }
}

class PricesBar extends GetView<PricesBarController> {
  const PricesBar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PricesBarController());
    return GetBuilder<PricesBarController>(initState: (state) {
      controller.getCaratPrices();
    }, builder: (_) {
      return controller.isLoading
          ? SizedBox(
              width: ScreenDimensions.screenWidth(context),
              height: ScreenDimensions.heightPercentage(context, 9),
              child: Directions(
                child: Stack(
                  children: [
                    Image.asset(AppImages.buttonLiteBackground,
                        filterQuality: FilterQuality.high,
                        isAntiAlias: true,
                        gaplessPlayback: true,
                        fit: BoxFit.fill,
                        height: ScreenDimensions.heightPercentage(context, 8),
                        width: ScreenDimensions.screenWidth(context)),
                  ],
                ).marginSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 0.7)),
              ),
            )
          : SizedBox(
              width: ScreenDimensions.screenWidth(context),
              height: ScreenDimensions.heightPercentage(context, 9),
              child: Directions(
                child: Stack(
                  children: [
                    Image.asset(AppImages.buttonLiteBackground,
                        filterQuality: FilterQuality.high,
                        isAntiAlias: true,
                        gaplessPlayback: true,
                        fit: BoxFit.fill,
                        height: ScreenDimensions.heightPercentage(context, 8),
                        width: ScreenDimensions.screenWidth(context)),
                    Positioned(
                      right: ScreenDimensions.widthPercentage(context, 3),
                      top: ScreenDimensions.heightPercentage(context, 1),
                      child: DelayedDisplay(
                        child: Row(
                          children: [
                            Text(
                              '${AppWord.sad} ${controller.model!.carat24.toInt()}',
                              style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),
                            ),
                            SizedBox(
                              width:
                                  ScreenDimensions.widthPercentage(context, 3),
                            ),
                            Text(
                              '${AppWord.goldCaliber} 24',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFonts.smallTitleFont(context),
                                  color: CustomColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: ScreenDimensions.widthPercentage(context, 13),
                      top: ScreenDimensions.heightPercentage(context, 4),
                      child: DelayedDisplay(
                        child: Row(
                          children: [
                            Text(
                              '${AppWord.sad} ${controller.model!.carat21.toInt()}',
                              style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),
                            ),
                            SizedBox(
                              width:
                                  ScreenDimensions.widthPercentage(context, 3),
                            ),
                            Text(
                              '${AppWord.goldCaliber} 21',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFonts.smallTitleFont(context),
                                  color: CustomColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: ScreenDimensions.widthPercentage(context, 3),
                      top: ScreenDimensions.heightPercentage(context, 1),
                      child: DelayedDisplay(
                        child: Row(
                          children: [
                            Text(
                              '${AppWord.sad} ${controller.model!.carat22.toInt()}',
                              style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),
                            ),
                            SizedBox(
                              width:
                                  ScreenDimensions.widthPercentage(context, 3),
                            ),
                            Text(
                              '${AppWord.goldCaliber} 22',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFonts.smallTitleFont(context),
                                  color: CustomColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: ScreenDimensions.widthPercentage(context, 13),
                      top: ScreenDimensions.heightPercentage(context, 4),
                      child: DelayedDisplay(
                        child: Row(
                          children: [
                            Text(
                              '${AppWord.sad} ${controller.model!.carat18.toInt()}',
                              style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),
                            ),
                            SizedBox(
                              width:
                                  ScreenDimensions.widthPercentage(context, 3),
                            ),
                            Text(
                              '${AppWord.goldCaliber} 18',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFonts.smallTitleFont(context),
                                  color: CustomColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).marginSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 0.7)),
              ),
            );
    });
  }
}

class PricesBarController extends GetxController {
  bool isLoading = true;
  CaratPricesModel? model;

  void getCaratPrices() async {
    Map<String, dynamic> data = await DioHelper.getCaratPrices();
    model = CaratPricesModel.fromJson(json: data['data']);
    isLoading = false;
    update();
  }
}

class AllCaratPrices extends GetxController {
  bool isLoading = true;
  late String carat;
  late double caratPrice;
  // AllCaratPricesModel? allCaratPricesModel;

  void getCaratPrices() async {
    Map<String, dynamic> data = await DioHelper.getAllCaratPrices();
    caratPrice = data['data']['data'][carat];
    // allCaratPricesModel = AllCaratPricesModel.fromJson(json: data['data']['data']);
    print(data.toString());
    isLoading = false;
    update();
  }
  @override
  void onInit() {
    getCaratPrices();
    super.onInit();
  }
}

class CaratPricesModel {
  final double carat18;
  final double carat21;
  final double carat22;
  final double carat24;

  CaratPricesModel(
      {required this.carat18,
      required this.carat21,
      required this.carat22,
      required this.carat24});

  factory CaratPricesModel.fromJson({required Map<String, dynamic> json}) {
    return CaratPricesModel(
      carat18: json['18k'],
      carat21: json['21k'],
      carat22: json['22k'],
      carat24: json['24k'],
    );
  }
}

class AllCaratPricesModel {
  final double carat6;
  final double carat8;
  final double carat9;
  final double carat10;
  final double carat12;
  final double carat14;
  final double carat16;
  final double carat18;
  final double carat21;
  final double carat21k;
  final double carat22;
  final double carat23;
  final double carat24;

  AllCaratPricesModel(
      {
      required this.carat6,
      required this.carat8,
      required this.carat9,
      required this.carat10,
      required this.carat12,
      required this.carat14,
      required this.carat16,
      required this.carat18,
      required this.carat21,
      required this.carat21k,
      required this.carat22,
      required this.carat23,
      required this.carat24,
      });

  factory AllCaratPricesModel.fromJson({required Map<String, dynamic> json}) {
    return AllCaratPricesModel(
      carat6: json['6k'],
      carat8: json['8k'],
      carat9: json['9k'],
      carat10: json['10k'],
      carat12: json['12k'],
      carat14: json['14k'],
      carat16: json['16k'],
      carat18: json['18k'],
      carat21: json['21k'],
      carat21k: json['21.6k'],
      carat22: json['22k'],
      carat23: json['23k'],
      carat24: json['24k'],
    );
  }
}

class ProfileProductPurchasesModel {
  final int id;
  final String? code;
  final int userId;
  final String description;
  final String age;
  final dynamic weight;
  final dynamic carat;
  final int subcategoryId;
  final dynamic currentGoldPrice;
  final dynamic profit;
  final dynamic addition;
  final String? details;
  final String? manufacturer;
  final String deliveryType;
  final String? offerDescription;
  final dynamic discountValue;
  final String productStatus;
  final dynamic price;
  final dynamic priceAfterDiscount;
  final List<dynamic> images;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final int orderId;
  final dynamic longitude;
  final dynamic latitude;
  final String country;
  final String state;
  final String city;
  final String neighborhood;
  final String street;
  final LocationEntity? location;

  ProfileProductPurchasesModel({
    required this.id,
    this.code,
    required this.userId,
    required this.description,
    required this.age,
    required this.weight,
    required this.carat,
    required this.subcategoryId,
    required this.currentGoldPrice,
    required this.profit,
    required this.addition,
    this.details,
    this.manufacturer,
    required this.deliveryType,
    this.offerDescription,
    this.discountValue,
    required this.productStatus,
    required this.price,
    required this.priceAfterDiscount,
    required this.images,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.orderId,
    required this.longitude,
    required this.latitude,
    required this.country,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.location,
  });

  factory ProfileProductPurchasesModel.fromJson({required Map<String, dynamic> json}) {
    return ProfileProductPurchasesModel(
      id: json['product']['id'],
      code: json['product']['code'],
      userId: json['product']['user_id'],
      description: json['product']['description'],
      age: json['product']['age'],
      weight: json['product']['wight'],
      carat: json['product']['carat'],
      subcategoryId: json['product']['subcategory_id'],
      currentGoldPrice: json['product']['current_gold_price'],
      profit: json['product']['profit'],
      addition: json['product']['addition'],
      details: json['product']['details'],
      manufacturer: json['product']['manufacture'],
      deliveryType: json['product']['delivery_type'],
      offerDescription: json['product']['offer_description'],
      productStatus: json['product']['product_status'],
      price: json['product']['price'],
      priceAfterDiscount: json['product']['price_after_discount'],
      images: json['product']['images'],
      firstName: json['seller']['first_name'],
      lastName: json['seller']['last_name'],
      phoneNumber: json['seller']['phone_number'],
      orderId: json['order_id'],
      longitude: json['receiving_location']['longitude'],
      latitude: json['receiving_location']['latitude'] ,
      country: json['receiving_location']['country'] ,
      state: json['receiving_location']['state'] ,
      city: json['receiving_location']['city'] ,
      neighborhood: json['receiving_location']['neighborhood'] ,
      street: json['receiving_location']['street'] ,
      location: LocationEntity(lat: json['receiving_location']['latitude'],lon: json['receiving_location']['longitude']),
    );
  }
}
class ProfileProductPutAsidePurchasesModel {
  final int id;
  final String? code;
  final int userId;
  final String description;
  final String age;
  final dynamic weight;
  final dynamic carat;
  final int subcategoryId;
  final dynamic currentGoldPrice;
  final dynamic profit;
  final dynamic addition;
  final String? details;
  final String? manufacturer;
  final String deliveryType;
  final String? offerDescription;
  final dynamic discountValue;
  final String productStatus;
  final dynamic price;
  final dynamic priceAfterDiscount;
  final List<dynamic> images;
  final int orderId;
  ProfileProductPutAsidePurchasesModel({
    required this.id,
    this.code,
    required this.userId,
    required this.description,
    required this.age,
    required this.weight,
    required this.carat,
    required this.subcategoryId,
    required this.currentGoldPrice,
    required this.profit,
    required this.addition,
    this.details,
    this.manufacturer,
    required this.deliveryType,
    this.offerDescription,
    this.discountValue,
    required this.productStatus,
    required this.price,
    required this.priceAfterDiscount,
    required this.images,
    required this.orderId,
  });

  factory ProfileProductPutAsidePurchasesModel.fromJson({required Map<String, dynamic> json}) {
    return ProfileProductPutAsidePurchasesModel(
      id: json['product']['id'],
      code: json['product']['code'],
      userId: json['product']['user_id'],
      description: json['product']['description'],
      age: json['product']['age'],
      weight: json['product']['wight'],
      carat: json['product']['carat'],
      subcategoryId: json['product']['subcategory_id'],
      currentGoldPrice: json['product']['current_gold_price'],
      profit: json['product']['profit'],
      addition: json['product']['addition'],
      details: json['product']['details'],
      manufacturer: json['product']['manufacture'],
      deliveryType: json['product']['delivery_type'],
      offerDescription: json['product']['offer_description'],
      productStatus: json['product']['product_status'],
      price: json['product']['price'],
      priceAfterDiscount: json['product']['price_after_discount'],
      images: json['product']['images'],
      orderId: json['order_id'],
    );
  }
}
class ProfileProductSellsModel {
  final LocationEntity location;
  final int id;
  final String? code;
  final int userId;
  final String description;
  final String age;
  final dynamic weight;
  final dynamic carat;
  final int subcategoryId;
  final dynamic currentGoldPrice;
  final dynamic profit;
  final dynamic addition;
  final String? details;
  final String? manufacturer;
  final String deliveryType;
  final String? offerDescription;
  final dynamic discountValue;
  final String productStatus;
  final dynamic price;
  final dynamic priceAfterDiscount;
  final List<dynamic> images;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final int orderId;
  final double longitude;
  final double latitude;
  final String country;
  final String state;
  final String city;
  final String neighborhood;
  final String street;

  ProfileProductSellsModel({
    required this.id,
    this.code,
    required this.userId,
    required this.description,
    required this.age,
    required this.weight,
    required this.carat,
    required this.subcategoryId,
    required this.currentGoldPrice,
    required this.profit,
    required this.addition,
    this.details,
    this.manufacturer,
    required this.deliveryType,
    this.offerDescription,
    this.discountValue,
    required this.productStatus,
    required this.price,
    required this.priceAfterDiscount,
    required this.images,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.orderId,
    required this.longitude,
    required this.latitude,
    required this.country,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.location,
  });

  factory ProfileProductSellsModel.fromJson({required Map<String, dynamic> json}) {
    return ProfileProductSellsModel(
      id: json['product']['id'],
      code: json['product']['code'],
      userId: json['product']['user_id'],
      description: json['product']['description'],
      age: json['product']['age'],
      weight: json['product']['wight'],
      carat: json['product']['carat'],
      subcategoryId: json['product']['subcategory_id'],
      currentGoldPrice: json['product']['current_gold_price'],
      profit: json['product']['profit'],
      addition: json['product']['addition'],
      details: json['product']['details'],
      manufacturer: json['product']['manufacture'],
      deliveryType: json['product']['delivery_type'],
      offerDescription: json['product']['offer_description'],
      productStatus: json['product']['product_status'],
      price: json['product']['price'],
      priceAfterDiscount: json['product']['price_after_discount'],
      images: json['product']['images'],
      firstName: json['buyer']['user']['first_name'].toString(),
      lastName: json['buyer']['user']['last_name'].toString(),
      phoneNumber: json['buyer']['user']['phone_number'].toString(),
      orderId: json['order_id'],
      longitude: json['receiving_location']['longitude'],
      latitude: json['receiving_location']['latitude'] ,
      country: json['receiving_location']['country'] ,
      state: json['receiving_location']['state'] ,
      city: json['receiving_location']['city'] ,
      neighborhood: json['receiving_location']['neighborhood'] ,
      street: json['receiving_location']['street'] ,
      location: LocationEntity(lon: json['receiving_location']['longitude'], lat: json['receiving_location']['latitude'])
    );
  }
}
class ProfilePutAsideSellsModel {
  final LocationEntity location;
  final int id;
  final String? code;
  final int userId;
  final String description;
  final String age;
  final dynamic weight;
  final dynamic carat;
  final int subcategoryId;
  final dynamic currentGoldPrice;
  final dynamic profit;
  final dynamic addition;
  final String? details;
  final String? manufacturer;
  final String deliveryType;
  final String? offerDescription;
  final dynamic discountValue;
  final String productStatus;
  final dynamic price;
  final dynamic priceAfterDiscount;
  final List<dynamic> images;
  final int orderId;
  final double longitude;
  final double latitude;
  final String country;
  final String state;
  final String city;
  final String neighborhood;
  final String street;

  ProfilePutAsideSellsModel({
    required this.id,
    this.code,
    required this.userId,
    required this.description,
    required this.age,
    required this.weight,
    required this.carat,
    required this.subcategoryId,
    required this.currentGoldPrice,
    required this.profit,
    required this.addition,
    this.details,
    this.manufacturer,
    required this.deliveryType,
    this.offerDescription,
    this.discountValue,
    required this.productStatus,
    required this.price,
    required this.priceAfterDiscount,
    required this.images,
    required this.orderId,
    required this.longitude,
    required this.latitude,
    required this.country,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.location,
  });

  factory ProfilePutAsideSellsModel.fromJson({required Map<String, dynamic> json}) {
    return ProfilePutAsideSellsModel(
      id: json['product']['id'],
      code: json['product']['code'],
      userId: json['product']['user_id'],
      description: json['product']['description'],
      age: json['product']['age'],
      weight: json['product']['wight'],
      carat: json['product']['carat'],
      subcategoryId: json['product']['subcategory_id'],
      currentGoldPrice: json['product']['current_gold_price'],
      profit: json['product']['profit'],
      addition: json['product']['addition'],
      details: json['product']['details'],
      manufacturer: json['product']['manufacture'],
      deliveryType: json['product']['delivery_type'],
      offerDescription: json['product']['offer_description'],
      productStatus: json['product']['product_status'],
      price: json['product']['price'],
      priceAfterDiscount: json['product']['price_after_discount'],
      images: json['product']['images'],
      orderId: json['order_id'],
      longitude: json['receiving_location']['longitude'],
      latitude: json['receiving_location']['latitude'] ,
      country: json['receiving_location']['country'] ,
      state: json['receiving_location']['state'] ,
      city: json['receiving_location']['city'] ,
      neighborhood: json['receiving_location']['neighborhood'] ,
      street: json['receiving_location']['street'] ,
      location: LocationEntity(lon: json['receiving_location']['longitude'], lat: json['receiving_location']['latitude'])
    );
  }
}
class ProfileMyProductsModel {
  final int id;
  final String? code;
  final int userId;
  final String description;
  final String age;
  final dynamic weight;
  final dynamic carat;
  final int subcategoryId;
  final dynamic currentGoldPrice;
  final dynamic profit;
  final dynamic addition;
  final String? details;
  final String? manufacturer;
  final String deliveryType;
  final String? offerDescription;
  final dynamic discountValue;
  final String productStatus;
  final dynamic price;
  final dynamic priceAfterDiscount;
  final List<dynamic> images;
  final List<String> phoneNumbers;

  ProfileMyProductsModel({
    required this.id,
    this.code,
    required this.userId,
    required this.description,
    required this.age,
    required this.weight,
    required this.carat,
    required this.subcategoryId,
    required this.currentGoldPrice,
    required this.profit,
    required this.addition,
    this.details,
    this.manufacturer,
    required this.deliveryType,
    this.offerDescription,
    this.discountValue,
    required this.productStatus,
    required this.price,
    required this.priceAfterDiscount,
    required this.images,
    required this.phoneNumbers,
  });

  factory ProfileMyProductsModel.fromJson({required Map<String, dynamic> json}) {
    List<String> myPhoneNumbers = [];
    json['product']['phone_numbers'].map((e) => myPhoneNumbers.add(e['phone_number'])).toList();
    return ProfileMyProductsModel(
      id: json['product']['id'],
      code: json['product']['code'],
      userId: json['product']['user_id'],
      description: json['product']['description'],
      age: json['product']['age'],
      weight: json['product']['wight'],
      carat: json['product']['carat'],
      subcategoryId: json['product']['subcategory_id'],
      currentGoldPrice: json['product']['current_gold_price'],
      profit: json['product']['profit'],
      addition: json['product']['addition'],
      details: json['product']['details'],
      manufacturer: json['product']['manufacture'],
      deliveryType: json['product']['delivery_type'],
      offerDescription: json['product']['offer_description'],
      productStatus: json['product']['product_status'],
      price: json['product']['price'],
      priceAfterDiscount: json['product']['price_after_discount'],
      images: json['product']['images'],
      phoneNumbers: myPhoneNumbers,
    );
  }
}

