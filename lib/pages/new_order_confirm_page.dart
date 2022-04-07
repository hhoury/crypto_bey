// ignore_for_file: use_key_in_widget_constructors

import 'package:crypto_bey/widgets/order_detail_bottom.dart';
import 'package:flutter/material.dart';

class NewOrderConfirmationPage extends StatelessWidget {
  static const routeName = '/order-confirmation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text('Order Detail'),
            const Text('Please confirm the order'),
            //  OrderDetailBottom(retailer: retailer, orderNumber: orderNumber, link: link, fee: fee, paid: paid, address: address, receiver: receiver, note: note, orderStatus: orderStatus),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                ElevatedButton(onPressed: null, child: Text('PREVIOUS')),
                ElevatedButton(onPressed: null, child: Text('CONFIRM')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
