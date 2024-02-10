
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/utils/dimensions.dart';


class MyPurchasesDropDownMenu extends StatelessWidget {
  const MyPurchasesDropDownMenu({super.key,  required this.title, required this.items, required this.onSelected});
  final String title;
  final List<PopupMenuItem> items ;
  final PopupMenuItemSelected onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onSelected,
      elevation: 1,
      color: CustomColors.white,
      itemBuilder: (BuildContext context) {
        return items;
      },
      shape: const LinearBorder(),
      child: Container(
        width: ScreenDimensions.widthPercentage(context, 40),
        height: ScreenDimensions.heightPercentage(context, 4),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(
            ScreenDimensions.widthPercentage(context, 5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.keyboard_arrow_down_rounded),
            Text(
              title,
            ),
          ],
        ).paddingSymmetric(
            horizontal: ScreenDimensions.widthPercentage(context, 2)),
      ),
    );
  }
}