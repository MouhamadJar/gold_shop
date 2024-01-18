import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/utils/dimensions.dart';

import '../components/categories_components.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SizedBox(
        width: ScreenDimensions.screenWidth(context),
        height: ScreenDimensions.screenHeight(context),
        child: const Category().paddingSymmetric(
            vertical: ScreenDimensions.heightPercentage(context, 2)),
      ),
    );
  }
}
