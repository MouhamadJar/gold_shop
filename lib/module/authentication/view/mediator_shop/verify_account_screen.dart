import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/utils/dimensions.dart';

import '../../../../core/components/components.dart';
import '../../../../core/images/images.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';

class VerifyMediatorAccount extends StatelessWidget {
  const VerifyMediatorAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: CustomColors.white,
        elevation: 10,
        title: Text(
          AppWord.activateAccount,
          style: TextStyle(
            fontSize: AppFonts.subTitleFont(context),
            fontWeight: FontWeight.bold,
            color: CustomColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: ScreenDimensions.screenWidth(context),
              height: ScreenDimensions.heightPercentage(context, 2),
            ),
            Text(
              AppWord.verificationAccountTerms,
              style: TextStyle(
                fontSize: AppFonts.subTitleFont(context),
                fontWeight: FontWeight.bold,
                color: CustomColors.black,
              ),
              textAlign: TextAlign.center,
            ).paddingSymmetric(
                horizontal: ScreenDimensions.widthPercentage(context, 5)),
            AppTextField(
              title: AppWord.phoneNumber,
              keyboardType: TextInputType.phone,
              suffix: const Icon(Icons.call),
            )
                .paddingSymmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 5))
                .marginOnly(
                    bottom: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
              title: AppWord.identifierNumber,
              keyboardType: TextInputType.phone,
            )
                .paddingSymmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 5))
                .marginOnly(
                    bottom: ScreenDimensions.heightPercentage(context, 2)),
            AppTextField(
              title: AppWord.tradingFile,
              keyboardType: TextInputType.name,
            )
                .paddingSymmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 5))
                .marginOnly(
                    bottom: ScreenDimensions.heightPercentage(context, 2)),
            Row(
              children: [
                Text(
                  AppWord.tradingFileImage,
                  style: TextStyle(
                    fontSize: AppFonts.subTitleFont(context),
                    fontWeight: FontWeight.bold,
                    color: CustomColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_box,
                    color: CustomColors.gold,
                    size: ScreenDimensions.widthPercentage(context, 8),
                  ),
                ),
              ],
            ).paddingSymmetric(
                horizontal: ScreenDimensions.widthPercentage(context, 5)),
            AppTextField(
              title: AppWord.insurance,
              keyboardType: TextInputType.name,
            )
                .paddingSymmetric(
                    horizontal: ScreenDimensions.widthPercentage(context, 5))
                .marginOnly(
                    bottom: ScreenDimensions.heightPercentage(context, 2)),
            Row(
              children: [
                Text(
                  AppWord.insuranceImage,
                  style: TextStyle(
                    fontSize: AppFonts.subTitleFont(context),
                    fontWeight: FontWeight.bold,
                    color: CustomColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_box,
                    color: CustomColors.gold,
                    size: ScreenDimensions.widthPercentage(context, 8),
                  ),
                ),
              ],
            ).paddingSymmetric(
                horizontal: ScreenDimensions.widthPercentage(context, 5)),

            AppButton(
                    text: Text(
                      AppWord.activateAccount,
                      style: TextStyle(
                        fontSize: AppFonts.smallTitleFont(context),
                        fontWeight: FontWeight.bold,
                        color: CustomColors.white,
                      ),
                    ),
                    onTap: () {},
                    buttonBackground: AppImages.buttonLiteBackground)
                .marginSymmetric(
              vertical: ScreenDimensions.heightPercentage(context, 10),
            ),
          ],
        ),
      ),
    );
  }
}
