import 'package:crypto_bey/models/address.dart';
import 'package:crypto_bey/providers/orders.dart';
import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../models/order.dart';

class OrderDetailBottom extends StatelessWidget {
  final Order order;
  final BuildContext context;
  const OrderDetailBottom(this.order, this.context);

  String get status {
    switch (order.status) {
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

  final String aliexpress = 'assets/images/aliexpress.png';
  final String amazon = 'assets/images/amazon.png';
  @override
  Widget build(BuildContext context) {
    Address orderAddress =
        Provider.of<Orders>(context).getAddressOfOrder(order.id);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  order.status == 'Delivering' ? aliexpress : amazon,
                  fit: BoxFit.cover,
                  width: 65,
                  height: 65,
                ),
              ),
              Text(
                'Order #${order.id}',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          Row(
            children: [
              Text('Fee:', style: Theme.of(context).textTheme.bodyText1),
              addHorizontalSpace(10),
              Text(
                order.paymentAmount.toString(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(order.paid ? 'Paid' : 'Unpaid')
            ],
          ),
          addVerticalSpace(10),
          Row(
            children: [
              Text('Shipping Address:',
                  style: Theme.of(context).textTheme.bodyText1),
              addHorizontalSpace(10),
              Text(
                orderAddress.address,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          addVerticalSpace(10),
          Row(
            children: [
              Text('Receiver:', style: Theme.of(context).textTheme.bodyText1),
              addHorizontalSpace(10),
              Text(
                orderAddress.name,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          addVerticalSpace(10),
          Row(
            children: [
              Text('Note:', style: Theme.of(context).textTheme.bodyText1),
              addHorizontalSpace(10),
              Text(
                order.note ?? '',
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          addVerticalSpace(10),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(status)])
        ],
      ),
    );
  }
}
