// ignore_for_file: use_key_in_widget_constructors

import 'package:crypto_bey/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

class OrderHistoryScreen extends StatelessWidget {
  static const routeName = '/order-history';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders History'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderItem(
              orderData.orders[index].id,
              orderData.orders[index].purchaseDate,
              orderData.orders[index].retailer,
              orderData.orders[index].status,
            );
          },
        ),
      ),
    );
  }
}
