import '../constants/app_constants.dart';

import '../models/order.dart';
import 'package:flutter/material.dart';

class NewOrderItem with ChangeNotifier {
  final String id;
  final Retailer retailer;
  final String orderLink;
  final String note;
  final String userId;
  final String addressId;
  NewOrderItem(this.id, this.userId, this.retailer, this.orderLink, this.note,
      this.addressId);
}

class Orders with ChangeNotifier {
  final List<Order> _orders = [
    Order(
        id: '1234-323456775',
        userId: 'john cena',
        addressId: '1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Ordered,
        retailer: Retailer.Aliexpress),
    Order(
        id: '1234-32',
        userId: 'john doe',
        addressId: '1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Delivering,
        retailer: Retailer.Amazon),
    Order(
        id: '1234-32',
        userId: 'john doe',
        addressId: '1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Payment,
        retailer: Retailer.Amazon),
    Order(
        id: '1234-32',
        userId: 'john doe',
        addressId: '1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Cancelled,
        retailer: Retailer.Amazon),
    Order(
        id: '1234-32',
        userId: 'john doe',
        addressId: '1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Delivered,
        retailer: Retailer.Amazon)
  ];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(Order newOrder) {
    //add order api
    _orders.insert(0, newOrder);
    notifyListeners();
  }

  Order findById(String id) {
    return _orders.firstWhere((order) => id == order.id);
  }
}
