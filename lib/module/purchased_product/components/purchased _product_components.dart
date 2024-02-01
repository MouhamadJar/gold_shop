import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/purchased_product/controller/prchased_product_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/images/images.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';

class PurchaseProcessDetails extends StatelessWidget {
  const PurchaseProcessDetails(
      {super.key, required this.title, required this.subtitle, this.amount});

  final String title;
  final String subtitle;
  final String? amount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenDimensions.screenWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: AlignmentDirectional.centerEnd,
            width: ScreenDimensions.widthPercentage(context, 20),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: AppFonts.smallTitleFont(context),
              ),
            ),
          ).paddingSymmetric(
              vertical: ScreenDimensions.heightPercentage(context, 1)),
          amount != null
              ? Container(
                  alignment: AlignmentDirectional.center,
                  width: ScreenDimensions.widthPercentage(context, 30),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            color: CustomColors.black),
                        text: amount),
                  ))
              : const SizedBox.shrink(),
          Container(
            alignment: AlignmentDirectional.centerEnd,
            width: ScreenDimensions.widthPercentage(context, 40),
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppFonts.smallTitleFont(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RateField extends StatelessWidget {
  const RateField({super.key, required this.title,this.onRatingUpdate,this.controller});

  final String title;

  final Function(double)? onRatingUpdate ;

  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RatingBar.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return SvgPicture.asset(AppImages.yellowStar);
                  },
                  onRatingUpdate: onRatingUpdate!,
                  itemCount: 5,
                  itemSize: ScreenDimensions.heightPercentage(context, 2),
                )
              ],
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: AppFonts.smallTitleFont(context),
              ),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 1)),
          ],
        ),
        Container(
          height: ScreenDimensions.heightPercentage(context, 7),
          margin: EdgeInsetsDirectional.symmetric(
              horizontal: ScreenDimensions.widthPercentage(context, 2)),
          decoration: BoxDecoration(border: Border.all()),
          child: TextFormField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ).paddingSymmetric(
              horizontal: ScreenDimensions.widthPercentage(context, 7)),
        ),
      ],
    );
  }
}
