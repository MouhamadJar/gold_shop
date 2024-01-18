import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../colors/colors.dart';
import '../images/images.dart';
import '../texts/words.dart';
import '../utils/app_fonts.dart';
import '../utils/dimensions.dart';

class AdvertisementBanner extends StatelessWidget {
  AdvertisementBanner({super.key, required this.items});

  List<Widget> items;

  // List<Widget> bannerRow;

  @override
  Widget build(BuildContext context) {
    // items!.forEach((element) {bannerRow.add(element);})
    return Directions(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0, 1],
            colors: [
              CustomColors.black,
              CustomColors.greyDark,
            ],
          ),
        ),
        width: ScreenDimensions.screenWidth(context),
        height: ScreenDimensions.heightPercentage(context, 15),
        child: CarouselSlider(
          items: items,
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 8),
          ),
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
      required this.onSelected});

  final String title;
  final List<PopupMenuItem> items;
  final PopupMenuItemSelected onSelected;

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
                size: ScreenDimensions.widthPercentage(context, 5)),
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

class PricesBar extends StatelessWidget {
  const PricesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_drop_down,
                    color: CustomColors.red,
                  ),
                  Text(
                    '${AppWord.sad} 205',
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 3),
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
            Positioned(
              right: ScreenDimensions.widthPercentage(context, 13),
              top: ScreenDimensions.heightPercentage(context, 4),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_drop_down,
                    color: CustomColors.red,
                  ),
                  Text(
                    '${AppWord.sad} 205',
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 3),
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
            Positioned(
              left: ScreenDimensions.widthPercentage(context, 3),
              top: ScreenDimensions.heightPercentage(context, 1),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_drop_down,
                    color: CustomColors.red,
                  ),
                  Text(
                    '${AppWord.sad} 205',
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 3),
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
            Positioned(
              left: ScreenDimensions.widthPercentage(context, 13),
              top: ScreenDimensions.heightPercentage(context, 4),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_drop_down,
                    color: CustomColors.red,
                  ),
                  Text(
                    '${AppWord.sad} 205',
                  ),
                  SizedBox(
                    width: ScreenDimensions.widthPercentage(context, 3),
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
          ],
        ).marginSymmetric(
            vertical: ScreenDimensions.heightPercentage(context, 0.7)),
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
      ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
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
  const ProductImages({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      padding: EdgeInsetsDirectional.symmetric(
          horizontal: ScreenDimensions.widthPercentage(context, 1),
          vertical: ScreenDimensions.heightPercentage(context, 1)),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenDimensions.widthPercentage(context, 2),
          ),
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
            child: Padding(
              padding: EdgeInsets.all(
                ScreenDimensions.heightPercentage(context, 1),
              ),
              child:
                  SvgPicture.asset(AppImages.bannerImage1, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
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
      required this.buttonButtonBackground});

  final String title;

  final String description;
  final Widget card1;
  final Widget? card2;
  final GestureTapCallback onTap;
  final String buttonName;
  final String buttonButtonBackground;

  @override
  Widget build(BuildContext context) {
    return Directions(
      child: Container(
          decoration: BoxDecoration(border: Border.all()),
          padding: EdgeInsetsDirectional.symmetric(
              vertical: ScreenDimensions.heightPercentage(context, 20),
              horizontal: ScreenDimensions.widthPercentage(context, 5)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
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
                          fontSize: AppFonts.subTitleFont(context) - 2,
                          color: CustomColors.yellow,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(blurRadius: 3, color: CustomColors.shadow),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: AppFonts.smallTitleFont(context),
                    ),
                  ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 2)),
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
          )),
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
  const AppTextField({
    super.key,
    this.title,
    required this.keyboardType,
    this.label,
    this.controller,
    this.enabled,
    this.prefix,
    this.suffix,
    this.suffixIconColor,
    this.prefixIconColor,
    this.maxLines,
    this.validator,
  });

  final String? title;
  final TextInputType keyboardType;
  final Widget? label;
  final TextEditingController? controller;
  final bool? enabled;
  final Widget? suffix;
  final MaterialColor? suffixIconColor;
  final MaterialColor? prefixIconColor;
  final Widget? prefix;
  final int? maxLines;
  final FormFieldValidator? validator;

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
            validator: validator,
            maxLines: maxLines,
            enabled: enabled,
            controller: controller,
            textAlign: TextAlign.end,
            cursorColor: CustomColors.gold,
            style: TextStyle(
              fontSize: AppFonts.smallTitleFont(context),
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
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
