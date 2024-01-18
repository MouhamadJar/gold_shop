import 'package:flutter/material.dart';
import 'package:gold_shop/core/colors/colors.dart';
import 'package:gold_shop/core/texts/words.dart';
import 'package:gold_shop/core/utils/app_fonts.dart';
import 'package:gold_shop/core/utils/dimensions.dart';
import 'package:gold_shop/module/my_reserved_sells/components/my_reserved_sells_components.dart';

class MyReservedSells extends StatelessWidget {
  const MyReservedSells({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: MyReservedSellsCard());
  }
}
