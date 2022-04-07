import 'package:flutter/material.dart';

class OrderDetailTop extends StatelessWidget {
  // final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('/assets/images/order.png'),
          const SizedBox(
            height: 5,
          ),
          const Text('Waiting for our agent to submit the order.')
        ],
      ),
    );
  }
}
