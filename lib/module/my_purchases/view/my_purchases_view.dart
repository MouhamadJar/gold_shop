import 'package:flutter/material.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/my_purchases/components/my_purchases_components.dart';

class MyPurchases extends StatelessWidget {
  const MyPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
          width: ScreenDimensions.screenWidth(context),
          height: ScreenDimensions.screenHeight(context),
          child: const PurchasesCard()),
    );
  }
}
