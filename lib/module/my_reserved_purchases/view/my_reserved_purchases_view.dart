import 'package:flutter/material.dart';
import 'package:gold_shop/module/my_reserved_purchases/components/my_reserved_purchases_components.dart';

import '../../../core/utils/dimensions.dart';

class MyReservedPurchases extends StatelessWidget {
  const MyReservedPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: ScreenDimensions.screenWidth(context),
        height: ScreenDimensions.screenHeight(context),
        child: const ReservedCard(),
      ),
    );
  }
}
