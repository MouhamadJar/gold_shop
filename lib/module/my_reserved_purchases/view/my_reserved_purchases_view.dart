import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/my_reserved_purchases/components/my_reserved_purchases_components.dart';
import 'package:gold_shop/module/my_reserved_purchases/controller/my_reserved_purchases_controller.dart';

import '../../../core/utils/dimensions.dart';

class MyReservedPurchases extends GetView<MyReservedPurchasesController> {
  const MyReservedPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyReservedPurchasesController());
    return GetBuilder<MyReservedPurchasesController>(
      initState: (state){
        controller.getMyReservedPurchases();
        controller.products.clear();
      },
      builder: (_) {
        return Expanded(
          child: SizedBox(
            width: ScreenDimensions.screenWidth(context),
            height: ScreenDimensions.screenHeight(context),
            child: const ReservedCard(),
          ),
        );
      }
    );
  }
}
