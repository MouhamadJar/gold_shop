import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/my_put_aside_purchases/controller/my_put_aside_purchases_controller.dart';
import 'package:gold_shop/module/my_put_aside_sells/components/my_put_aside_sells_components.dart';
import 'package:gold_shop/module/my_put_aside_sells/controller/my_put_aside_sells_controller.dart';

class MyPutAsideSells extends GetView<MyPutAsideSellsController> {
  const MyPutAsideSells({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyPutAsideSellsController());
    return GetBuilder<MyPutAsideSellsController>(initState: (state) {
      controller.products.clear();
      controller.getMyPutAsideProducts();
    }, builder: (_) {
      return const Expanded(child: MyPutAsideSellsCard());
    });
  }
}
