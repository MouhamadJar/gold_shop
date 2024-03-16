import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/authentication/view/mediator_shop/verify_account_screen.dart';
import 'package:gold_shop/module/main/mediator_shop/mediator_shop_profile/view/mediator_shop_profile.dart';
import 'package:gold_shop/module/main/mediator_shop/product_code/view/product_code_view.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/components/components.dart';
import '../../../../../core/images/images.dart';
import '../../../../../core/texts/words.dart';
import '../../../../../core/utils/app_fonts.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../authentication/view/login_screen.dart';
import '../../../../map/view/mediator_shops_map_screen.dart';
import '../../../user/components/components.dart';
import '../controller/signature_controller.dart';

class MediatorShopHome extends GetView<SignatureController> {
  const MediatorShopHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignatureController());
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        backgroundColor: CustomColors.white,
        drawerEdgeDragWidth: ScreenDimensions.widthPercentage(context, 20),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppWord.home,
            style: TextStyle(
              color: CustomColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.subTitleFont(context),
            ),
          ),
          elevation: 1,
          backgroundColor: CustomColors.white,
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                AppWord.eSignaturePic,
                style: TextStyle(
                    shadows: [
                      Shadow(blurRadius: 3, color: CustomColors.shadow)
                    ],
                    color: CustomColors.yellow,
                    fontSize: AppFonts.subTitleFont(context),
                    fontWeight: FontWeight.bold),
              ),
            ).paddingSymmetric(
                horizontal: ScreenDimensions.heightPercentage(context, 3),
                vertical: ScreenDimensions.heightPercentage(context, 3)),
            Align(
              alignment: AlignmentDirectional.center,
              child: GestureDetector(
                onTap: controller.pickSignatureImage,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  height: ScreenDimensions.heightPercentage(context, 7),
                  width: ScreenDimensions.widthPercentage(context, 60),
                  decoration: BoxDecoration(
                      color: CustomColors.white,
                      boxShadow: [
                        BoxShadow(
                            color: CustomColors.shadow,
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(0, 3),
                            spreadRadius: 0.1),
                      ],
                      borderRadius: BorderRadius.circular(
                          ScreenDimensions.radius(context, 1))),
                  child: GetBuilder<SignatureController>(builder: (_) {
                    return controller.signatureImage != null
                        ? Image.file(controller.signatureImage!)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AppWord.uploadPicture,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppFonts.smallTitleFont(context),
                                ),
                              ),
                              SvgPicture.asset(
                                AppImages.upload,
                                height: ScreenDimensions.heightPercentage(
                                    context, 2.5),
                              ),
                            ],
                          );
                  }),
                ),
              ),
            ).paddingSymmetric(
                vertical: ScreenDimensions.heightPercentage(context, 4)),
            const Spacer(),
            GetBuilder<SignatureController>(builder: (_) {
              return controller.isLoading
                  ? const CircularProgressIndicator().marginSymmetric(vertical: 24)
                  : AppButton(
                          text: Text(
                            AppWord.done,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.smallTitleFont(context),
                                color: CustomColors.white),
                          ),
                          onTap: controller.checkSignature,
                          buttonBackground: AppImages.buttonLiteBackground)
                      .paddingSymmetric(
                          vertical:
                              ScreenDimensions.heightPercentage(context, 2));
            }),
          ],
        ),
      ),
    );
  }
}
