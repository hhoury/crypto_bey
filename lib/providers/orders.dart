import 'package:crypto_bey/models/order.dart';
import 'package:flutter/material.dart';

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orderes {
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
