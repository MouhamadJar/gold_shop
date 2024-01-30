import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/my_reserved_sells/components/my_reserved_sells_components.dart';
import 'package:gold_shop/module/my_reserved_sells/controller/my_reserved_sells_controller.dart';

class MyReservedSells extends GetView<MyReservedSellsController> {
  const MyReservedSells({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyReservedSellsController());
    return GetBuilder<MyReservedSellsController>(
      initState: (state){
        controller.products.clear();
        controller.getMyReservedSells();
      },
      builder: (_) {
        return const Expanded(child: MyReservedSellsCard());
      }
    );
  }
}
