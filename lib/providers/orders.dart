import '../constants/app_constants.dart';

import '../models/order.dart';
import 'package:flutter/material.dart';

class Orders with ChangeNotifier {
  final List<Order> _orders = [
    Order(
        id: 1,
        userId: 1,
        addressId: 1,
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        itemUrl: 'itemurlhere',
        updatedDate: DateTime.now(),
        status: OrderStatus.AWAITING_ORDER,
        retailer: Retailer.ALIEXPRESS),
    Order(
        id: 2,
        userId: 1,
        addressId: 1,
        itemUrl: 'itemurlhere',
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        updatedDate: DateTime.now(),
        status: OrderStatus.AWAITING_DELIVERY,
        retailer: Retailer.AMAZON),
    Order(
        id: 3,
        userId: 1,
        addressId: 1,
        itemUrl: 'itemurlhere',
        updatedDate: DateTime.now(),
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.AWAITING_PAYMENT,
        retailer: Retailer.AMAZON),
    Order(
        id: 4,
        userId: 2,
        addressId: 1,
        itemUrl: 'itemurlhere',
        updatedDate: DateTime.now(),
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.CANCELLED,
        retailer: Retailer.AMAZON),
    Order(
        id: 5,
        userId: 2,
        addressId: 1,
        itemUrl: 'itemurlhere',
        updatedDate: DateTime.now(),
        note: 'note',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.DELIVERED,
        retailer: Retailer.AMAZON)
  ];

  List<Order> get orders {
    return [..._orders.where((element) => element.deleted == false)];
  }

  void addOrder(Order newOrder) {
    //add order api
    _orders.insert(0, newOrder);
    notifyListeners();
  }

  Order findById(int id) {
    return _orders.firstWhere((order) => id == order.id);
  }

  void updateOrder(int id, Order updatedOrder) {
    final orderIndex = _orders.indexWhere((element) => element.id == id);
    if (orderIndex >= 0) {
      _orders[orderIndex] = updatedOrder;
    }
    notifyListeners();
  }

  void deleteOrder(int id) {
    final orderIndex = _orders.indexWhere((element) => element.id == id);
    if (orderIndex >= 0) {
      _orders[orderIndex].deleted = true;
    }
    notifyListeners();
  }
}
