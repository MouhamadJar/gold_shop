import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../colors/colors.dart';
import '../general_controllers/problems_controller.dart';
import '../images/images.dart';
import '../texts/words.dart';
import '../utils/app_fonts.dart';
import '../utils/dimensions.dart';
import 'components.dart';

void showProblemDialog({
  required BuildContext context,
  required int productId,
}) {
  ProblemsController controller = Get.find();
  Get.dialog(
    Directions(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
          child: Container(
            margin: EdgeInsetsDirectional.only(
                top: ScreenDimensions.heightPercentage(context, 5),
                bottom: ScreenDimensions.heightPercentage(context, 45),
                start: ScreenDimensions.widthPercentage(context, 5),
                end: ScreenDimensions.widthPercentage(context, 5)),
            padding: EdgeInsetsDirectional.all(
                ScreenDimensions.widthPercentage(context, 3)),
            color: CustomColors.white,
            child: GetBuilder<ProblemsController>(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(AppImages.x,
                                width:
                                    ScreenDimensions.widthPercentage(context, 3))),
                        Text(AppWord.reportProblem,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.smallTitleFont(context))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppPopUpMenu(
                            title:controller.selectedProblemType['name'],
                            items: controller.problems
                                .map(
                                  (e) => PopupMenuItem(
                                    child: Text(
                                      e['name'],
                                    ),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            onSelected: (value) {
                              controller.selectedProblemType = value;
                              controller.update();
                            }),
                        Text(
                          AppWord.defineProblem,
                          style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(
                      vertical: ScreenDimensions.heightPercentage(context, 4),
                    ),
                    Text(
                      AppWord.describeProblem,
                      style: TextStyle(fontSize: AppFonts.smallTitleFont(context)),
                    ).paddingOnly(
                        left: ScreenDimensions.widthPercentage(context, 60)),
                    Container(
                      height: ScreenDimensions.heightPercentage(context, 15),
                      margin: EdgeInsetsDirectional.symmetric(
                          horizontal: ScreenDimensions.widthPercentage(context, 8)),
                      decoration: BoxDecoration(border: Border.all()),
                      child: TextFormField(
                        controller: controller.descriptionController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ).paddingSymmetric(
                          horizontal: ScreenDimensions.widthPercentage(context, 7)),
                    ).paddingSymmetric(
                        vertical: ScreenDimensions.heightPercentage(context, 2)),
                    controller.isLoading ? Center(child: CircularProgressIndicator(color: CustomColors.gold,)):  AppButton(
                            text: Text(
                              AppWord.send,
                              style: TextStyle(
                                  color: CustomColors.white,
                                  fontSize: AppFonts.smallTitleFont(context),
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              controller.sendProblem(productId: productId);
                            },
                            buttonBackground: AppImages.buttonLiteBackground)
                        .paddingSymmetric(
                            vertical:
                                ScreenDimensions.heightPercentage(context, 1)),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    ),
  );
}
