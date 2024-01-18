import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/main/mediator_shop/edit_product/view/edit_product_view.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/images/images.dart';

class ProductCode extends StatelessWidget {
  const ProductCode({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: CustomColors.white,
        title: Text(
          AppWord.home,
          style: TextStyle(
              color: CustomColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.subTitleFont(context)),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              AppWord.enterProductCode,
              style: TextStyle(
                fontSize: AppFonts.subTitleFont(context) - 3,
              ),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 3),
                horizontal: ScreenDimensions.widthPercentage(context, 3)),
          ),
          const AppTextField(keyboardType: TextInputType.text).paddingSymmetric(
              vertical: ScreenDimensions.heightPercentage(context, 5),
              horizontal: ScreenDimensions.widthPercentage(context, 10)),
          const Spacer(),
          AppButton(
              text: Text(
                AppWord.done,
                style: TextStyle(
                    color: CustomColors.white,
                    fontSize: AppFonts.smallTitleFont(context),
                    fontWeight: FontWeight.bold),
              ),
              onTap: (){
                Get.to(const EditProduct(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 700));
              },
              buttonBackground: AppImages.buttonLiteBackground).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 2)),
        ],
      ),
    ));
  }
}
