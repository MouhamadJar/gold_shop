import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/module/ads_product/controller/ads_product_controller.dart';
import '../../../core/colors/colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';

class AdsProcessDetails extends StatelessWidget {
  const AdsProcessDetails(
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
class PhoneNumbersFields extends GetView<AdsProductController> {
  const PhoneNumbersFields(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    Get.put(AdsProductController());
    return GetBuilder<AdsProductController>(
      builder: (_) {
        return SizedBox(
          width: ScreenDimensions.screenWidth(context),
          height: ScreenDimensions.heightPercentage(context, 4)*controller.model!.phoneNumbers.length,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.model!.phoneNumbers.length,
            itemBuilder: (BuildContext context, int index) { return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  width: ScreenDimensions.widthPercentage(context, 20),
                  child: Text(
                    controller.model!.phoneNumbers[index],
                    style: TextStyle(
                      fontSize: AppFonts.smallTitleFont(context),
                    ),
                  ),
                ).paddingSymmetric(
                    vertical: ScreenDimensions.heightPercentage(context, 1)),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  width: ScreenDimensions.widthPercentage(context, 40),
                  child: Text(
                    AppWord.vendorNumber,
                    style: TextStyle(
                      fontSize: AppFonts.smallTitleFont(context),
                    ),
                  ),
                ),
              ],
            ) ; },
          ),
        );
      }
    );
  }
}
