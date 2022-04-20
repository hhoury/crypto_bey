import 'package:intl/intl.dart';

import '../constants/app_constants.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  String orederId;
  DateTime date;
  Retailer retailer;
  OrderStatus status;

  String get orderStatus {
    switch (status) {
      case OrderStatus.Cancelled:
        return 'Cancelled';
      case OrderStatus.Payment:
        return 'Waiting For Payment';
      case OrderStatus.Ordered:
        return 'Ordered';
      case OrderStatus.Delivering:
        return 'Delivering';
      case OrderStatus.Delivered:
        return 'Delivered';
      default:
        return 'Order';
    }
  }

  final Color orderDeliveredColor = const Color(0xFF27A745);
  final Color orderCancelledColor = const Color(0xFFDC3645);
  final Color orderWaitingForPaymentColor = const Color(0xFFFFC105);
  final Color orderDeliveringColor = const Color(0xFF17A2B8);
  final Color orderOrderedColor = const Color(0xFF6C757D);
  final String aliexpress = 'assets/images/aliexpress.png';
  final String amazon = 'assets/images/amazon.png';

  Color get orderStatusBg {
    switch (status) {
      case OrderStatus.Cancelled:
        return orderCancelledColor;
      case OrderStatus.Payment:
        return orderWaitingForPaymentColor;
      case OrderStatus.Ordered:
        return orderOrderedColor;
      case OrderStatus.Delivering:
        return orderDeliveringColor;
      case OrderStatus.Delivered:
        return orderDeliveredColor;
      default:
        return orderCancelledColor;
    }
  }

  OrderItem(this.orederId, this.date, this.retailer, this.status);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Theme.of(context).colorScheme.surface,
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          child: ListTile(
            onTap: () {},
            leading: FittedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  orderStatus == 'Delivering' ? aliexpress : amazon,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            title: FittedBox(
              child: Text('order #$orederId',
                  style: Theme.of(context).textTheme.headline2),
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            trailing: FittedBox(
                child: Container(
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: orderStatusBg),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  orderStatus,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white), // Color(0xFF383838)),
                  // style: TextStyle(
                  //     backgroundColor: orderStatusBg,
                  // ),
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
