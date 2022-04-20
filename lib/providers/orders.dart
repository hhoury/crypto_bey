import '../constants/app_constants.dart';

import '../models/order.dart';
import 'package:flutter/material.dart';

class Orders with ChangeNotifier {
  final List<Order> _orders = [
    Order(
        id: '1234-323456775',
        user: 'john cena',
        receiver: 'john cena',
        address: 'beirut bldg 1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Ordered,
        retailer: Retailer.Aliexpress),
    Order(
        id: '1234-32',
        user: 'john doe',
        receiver: 'john doe',
        address: 'beirut bldg 1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Delivering,
        retailer: Retailer.Amazon),
    Order(
        id: '1234-32',
        user: 'john doe',
        receiver: 'john doe',
        address: 'beirut bldg 1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Payment,
        retailer: Retailer.Amazon),
    Order(
        id: '1234-32',
        user: 'john doe',
        receiver: 'john doe',
        address: 'beirut bldg 1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Cancelled,
        retailer: Retailer.Amazon),
    Order(
        id: '1234-32',
        user: 'john doe',
        receiver: 'john doe',
        address: 'beirut bldg 1',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.Delivered,
        retailer: Retailer.Amazon)
  ];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder() {
    //add order api
    notifyListeners();
  }

  Order findById(String id) {
    return _orders.firstWhere((order) => id == order.id);
  }
}
