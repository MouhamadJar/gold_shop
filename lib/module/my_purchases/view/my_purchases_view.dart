import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/my_purchases/components/my_purchases_components.dart';
import 'package:gold_shop/module/my_purchases/controller/my_purchases_controller.dart';

class MyPurchases extends GetView<MyPurchasesController> {
  const MyPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyPurchasesController());
    return GetBuilder<MyPurchasesController>(
      initState:  (state){
        controller.getMyPurchases();
      },
      builder: (_) {
        return Expanded(
          child: SizedBox(
              width: ScreenDimensions.screenWidth(context),
              height: ScreenDimensions.screenHeight(context),
              child: const PurchasesCard()),
        );
      }
    );
  }
}
