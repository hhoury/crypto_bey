import '../constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  String orederId;
  DateTime date;
  Retailer retailer;
  OrderStatus status;

  String get orderStatus {
    switch (status) {
      case OrderStatus.Verification:
        return 'Verification';
      case OrderStatus.Payment:
        return 'Payment';
      case OrderStatus.Order:
        return 'Order';
      case OrderStatus.Delivering:
        return 'Delivering';
      case OrderStatus.Delivered:
        return 'Delivered';
      default:
        return 'Order';
    }
  }

  OrderItem(this.orederId, this.date, this.retailer, this.status);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('/assets/images/amazon.png'),
                Column(
                  children: [
                    Text('Order $orederId'),
                    Text(DateFormat.yMMMd().format(date))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  child: Text(orderStatus),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
