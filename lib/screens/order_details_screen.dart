// ignore_for_file: use_key_in_widget_constructors

import 'package:crypto_bey/providers/orders.dart';
import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:crypto_bey/widgets/order_detail_top.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/order_detail_bottom.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const routeName = '/order-details';
  final Widget svg = SvgPicture.asset('assets/images/delivered.svg',
      semanticsLabel: 'delivered');

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as int;
    final loadedOrder =
        Provider.of<Orders>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(30),
              FractionallySizedBox(
                widthFactor: 0.6,
                child: OrderDetailTop(loadedOrder, context),
              ),
              addVerticalSpace(10),
              OrderDetailBottom(loadedOrder, context),
            ],
          ),
        ),
      ),
    );
  }
}
