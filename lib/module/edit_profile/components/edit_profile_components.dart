import 'package:flutter/material.dart';
import 'package:gold_shop/core/components/components.dart';

import '../../../core/colors/colors.dart';
import '../../../core/texts/words.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/dimensions.dart';



class EditProfileCard extends StatelessWidget {
  const EditProfileCard({
    super.key, required this.title, required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: ScreenDimensions.widthPercentage(context, 40),
          height: ScreenDimensions.heightPercentage(context, 5),
          alignment: AlignmentDirectional.centerEnd,
          padding: EdgeInsetsDirectional.all(
            ScreenDimensions.widthPercentage(context, 2),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: CustomColors.shadow),
              borderRadius: BorderRadius.circular(
                  ScreenDimensions.radius(context, 1))),
          child: Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.smallTitleFont(context),
            ),
          ),
        ),
        Container(
          alignment: AlignmentDirectional.centerEnd,
          width: ScreenDimensions.widthPercentage(context, 15),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFonts.smallTitleFont(context),
            ),
          ),
        ),
      ],
    );
  }
}
