import 'package:flutter/material.dart';
import 'package:gold_shop/module/my_sells/components/my_sells_components.dart';

class MySells extends StatelessWidget {
  const MySells({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: MySellsCard());
  }
}
