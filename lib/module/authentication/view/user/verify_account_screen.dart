import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/utils/dimensions.dart';

import '../../../../core/components/components.dart';
import '../../../../core/images/images.dart';
import '../../../../core/texts/words.dart';
import '../../../../core/utils/app_fonts.dart';

class VerifyUserAccount extends StatelessWidget {
  const VerifyUserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        leading: const BackArrow(),
        backgroundColor: CustomColors.white,
        elevation: 1,
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
                    buttonBackground: AppImages.buttonLiteBackground).marginOnly(
              top: ScreenDimensions.heightPercentage(context, 50),
            ),
          ],
        ),
      ),
    );
  }
}

