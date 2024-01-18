import 'package:flutter/material.dart';
import 'package:gold_shop/module/my_put_aside_sells/components/my_put_aside_sells_components.dart';

class MyPutAsideSells extends StatelessWidget {
  const MyPutAsideSells({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: MyPutAsideSellsCard());
  }
}
