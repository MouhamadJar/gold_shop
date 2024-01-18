import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_shop/core/utils/dimensions.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/utils/app_fonts.dart';

class DrawerListTiles extends StatelessWidget {
  const DrawerListTiles(
      {super.key, required this.title, required this.imagePath, this.onTap});

  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        trailing: SvgPicture.asset(
          imagePath,
          width: ScreenDimensions.widthPercentage(context, 5),
        ),
        title: Text(
          title,
          textAlign: TextAlign.end,
          style: TextStyle(
            color: CustomColors.white,
            fontSize: AppFonts.smallTitleFont(context),
          ),
        ),
        onTap:onTap,
      ),
    );
  }
}
