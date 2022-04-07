// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  static const routeName = '/order-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset('/assets/images/delivered.png'),
          ],
        ),
      ),
    );
  }
}
