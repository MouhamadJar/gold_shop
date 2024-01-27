import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/my_put_aside_purchases/components/my_put_aside_purchases_components.dart';
import 'package:gold_shop/module/my_put_aside_purchases/controller/my_put_aside_purchases_controller.dart';

class MyPutAsidePurchases extends GetView<MyPutAsidePurchasesController> {
  const MyPutAsidePurchases({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyPutAsidePurchasesController());
    return GetBuilder<MyPutAsidePurchasesController>(
      initState: (state){
        controller.getMyPutAsidePurchases();
        controller.products.clear();
      },
      builder: (_) {
        return Expanded(
          child: SizedBox(
            height: ScreenDimensions.screenHeight(context),
              width: ScreenDimensions.screenWidth(context),
              child: const PutAsideCard()),
        );
      }
    );
  }
}
