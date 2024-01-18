// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/components/components.dart';
import 'package:gold_shop/core/images/images.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';

class ProfileLists extends StatelessWidget {
  const ProfileLists({super.key});

  @override
  Widget build(BuildContext context) {
    int itemCount = 5;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsetsDirectional.symmetric(
        vertical: ScreenDimensions.heightPercentage(context, 2),
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
        },
        child: SizedBox(
          width: ScreenDimensions.widthPercentage(context, 40),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                top: ScreenDimensions.heightPercentage(context, 3),
                child: Directions(
                  child: Container(
                    height: ScreenDimensions.heightPercentage(context, 15),
                    width: ScreenDimensions.widthPercentage(context, 35),
                    padding: EdgeInsetsDirectional.only(
                      end: ScreenDimensions.widthPercentage(context, 2),
                      start: ScreenDimensions.widthPercentage(context, 2),
                      bottom: ScreenDimensions.heightPercentage(context, 0)
                    ),
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        color: CustomColors.white1,
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(
                              ScreenDimensions.widthPercentage(context, 10),
                            ),
                            topEnd: Radius.circular(
                              ScreenDimensions.widthPercentage(context, 10),
                            )),
                        border: Border.all()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'GN12345',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppFonts.smallTitleFont(context),
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                        Container(
                          width: ScreenDimensions.widthPercentage(context, 20),
                          height: ScreenDimensions.heightPercentage(context, 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: CustomColors.yellow),
                              color: CustomColors.white,
                              borderRadius: BorderRadius.circular(ScreenDimensions.radius(context, 1))
                          ),
                          alignment: AlignmentDirectional.center,
                          child: Text(AppWord.details,style: TextStyle(color: CustomColors.gold,fontWeight: FontWeight.bold,fontSize: AppFonts.smallTitleFont(context)),),
                        ).paddingSymmetric(vertical: ScreenDimensions.heightPercentage(context, 1)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: ScreenDimensions.heightPercentage(context, 0),
                child: SvgPicture.asset(
                  width: ScreenDimensions.widthPercentage(context, 22),
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