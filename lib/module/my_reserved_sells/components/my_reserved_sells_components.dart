// ignore_for_file: non_constant_identifier_names

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/reserved_sell/view/reserved_sells_view.dart';

class MyReservedSellsCard extends StatelessWidget {
  const MyReservedSellsCard({super.key});

  @override
  Widget build(BuildContext context) {
    int itemCount = 10;
    return GridView.builder(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: ScreenDimensions.widthPercentage(context, 5),
        vertical: ScreenDimensions.heightPercentage(context, 2),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: ScreenDimensions.heightPercentage(context, 4),
        mainAxisSpacing: ScreenDimensions.widthPercentage(context, 2),
        mainAxisExtent: ScreenDimensions.heightPercentage(context, 25),
        // childAspectRatio: ScreenDimensions.heightPercentage(context, 0.06),
        crossAxisCount: 2,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {Get.to(const ReservedSell(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 500));},
        child: DelayedDisplay(
          slidingBeginOffset: const Offset(0,1),
          delay: Duration(milliseconds: (index*100)+100),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                width: ScreenDimensions.widthPercentage(context, 40),
                top: ScreenDimensions.heightPercentage(context, 3),
                height: ScreenDimensions.heightPercentage(context, 20),
                child: Directions(
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: ScreenDimensions.widthPercentage(context, 3),
                    ),
                    alignment: AlignmentDirectional.centerEnd,
                    decoration: BoxDecoration(
                        color: CustomColors.white1,
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(
                              ScreenDimensions.widthPercentage(context, 2),
                            ),
                            topEnd: Radius.circular(
                              ScreenDimensions.widthPercentage(context, 2),
                            )),
                        border: Border.all()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppWord.productContent,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: ScreenDimensions.heightPercentage(context, 1),
                        ),
                        Row(
                          children: [
                            Text(
                              '${AppWord.caliber} 18',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.smallTitleFont(context),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${AppWord.grams} 5',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.smallTitleFont(context),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.visibility_outlined),
                            Text(
                              '20',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.smallTitleFont(context),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${AppWord.sad} 1200',
                              style: TextStyle(
                                color: CustomColors.gold,
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.smallTitleFont(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: ScreenDimensions.heightPercentage(context, 0.01),
                width: ScreenDimensions.widthPercentage(context, 30),
                child: SvgPicture.asset(
                  width: ScreenDimensions.widthPercentage(context, 25),
                  AppImages.bannerImage1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
