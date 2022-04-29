import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class OrderDetailBottom extends StatelessWidget {
  final String orderNumber;
  final Retailer retailer;
  final bool paid;
  final String link;
  final double fee;
  final String address;
  final String receiver;
  final String note;
  final OrderStatus orderStatus;

  String get status {
    switch (orderStatus) {
      case OrderStatus.CANCELLED:
        return 'Cancelled';
      case OrderStatus.AWAITING_PAYMENT:
        return 'Payment';
      case OrderStatus.AWAITING_ORDER:
        return 'Ordered';
      case OrderStatus.AWAITING_DELIVERY:
        return 'Delivering';
      case OrderStatus.DELIVERED:
        return 'Delivered';
      default:
        return 'Order';
    }
  }

  const OrderDetailBottom({
    required this.retailer,
    required this.orderNumber,
    required this.link,
    required this.fee,
    required this.paid,
    required this.address,
    required this.receiver,
    required this.note,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('/assets/images/amazon.png'),
              Text('Order #$orderNumber')
            ],
          ),
          Row(
            children: [
              const Text('Fee:'),
              Text(fee.toString()),
              Text(paid ? 'Paid' : 'Unpaid')
            ],
          ),
          Row(
            children: [const Text('Shipping Address:'), Text(address)],
          ),
          Row(
            children: [const Text('Receiver:'), Text(receiver)],
          ),
          Row(
            children: [const Text('Note:'), Text(note)],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(status)])
        ],
      ),
    );
  }
}
