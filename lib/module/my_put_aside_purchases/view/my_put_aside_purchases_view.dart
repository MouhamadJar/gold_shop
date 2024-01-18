import 'package:flutter/material.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/my_put_aside_purchases/components/my_put_aside_purchases_components.dart';

class MyPutAsidePurchases extends StatelessWidget {
  const MyPutAsidePurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: ScreenDimensions.screenHeight(context),
          width: ScreenDimensions.screenWidth(context),
          child: const PutAsideCard()),
    );
  }
}
