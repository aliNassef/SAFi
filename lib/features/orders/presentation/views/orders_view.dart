import 'package:flutter/material.dart';
import '../../../home/data/model/price_args_model.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key, required this.priceArgs});
  static const routeName = 'OrdersView';
  final PriceArgsModel priceArgs;
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
