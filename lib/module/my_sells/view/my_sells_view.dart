import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/module/my_sells/components/my_sells_components.dart';
import 'package:gold_shop/module/my_sells/controller/my_sells_controller.dart';

class MySells extends GetView<MySellsController> {
  const MySells({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MySellsController());
    return GetBuilder<MySellsController>(
      initState: (state){
        controller.getMySells();
        controller.products.clear();
      },
      builder: (_) {
        return const Expanded(child: MySellsCard());
      }
    );
  }
}
