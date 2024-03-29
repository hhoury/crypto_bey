import 'dart:convert';

import 'package:crypto_bey/models/http_exception.dart';
import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../core/services/api.dart';
import '../models/address.dart';

import '../constants/app_constants.dart';

import '../models/order.dart';
import 'package:flutter/material.dart';

class Orders with ChangeNotifier {
  String refreshToken = '';
  String userId = '';
  final api = Api();
  // ignore: prefer_final_fields
  List<Order> _orders = [
    Order(
        id: 1,
        userId: 1,
        addressId: 1,
        note: 'Color Red, Size XL, leave it behind the door please',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        itemUrl: 'https://www.amazon.ca/TEUMI-WataD',
        updatedDate: DateTime.now(),
        status: OrderStatus.AWAITING_ORDER,
        retailer: Retailer.ALIEXPRESS),
    Order(
        id: 2,
        userId: 1,
        addressId: 1,
        itemUrl: 'https://www.amazon.ca/TEUMI-WataD',
        note: 'Color Red, Size XL, leave it behind the door please',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        updatedDate: DateTime.now(),
        status: OrderStatus.AWAITING_DELIVERY,
        paid: true,
        retailer: Retailer.AMAZON),
    Order(
        id: 3,
        userId: 1,
        addressId: 1,
        itemUrl: 'https://www.amazon.ca/TEUMI-WataD',
        updatedDate: DateTime.now(),
        note: 'Color Red, Size XL, leave it behind the door please',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.AWAITING_PAYMENT,
        retailer: Retailer.AMAZON),
    Order(
        id: 4,
        userId: 2,
        addressId: 1,
        itemUrl: 'https://www.amazon.ca/TEUMI-WataD',
        updatedDate: DateTime.now(),
        note: 'Color Red, Size XL, leave it behind the door please',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.CANCELLED,
        retailer: Retailer.AMAZON),
    Order(
        id: 5,
        userId: 2,
        addressId: 1,
        itemUrl: 'https://www.amazon.ca/TEUMI-WataD',
        updatedDate: DateTime.now(),
        note: 'Color Red, Size XL, leave it behind the door please',
        paymentAmount: 200,
        purchaseDate: DateTime.now(),
        status: OrderStatus.DELIVERED,
        paid: true,
        retailer: Retailer.AMAZON)
  ];

  Orders(this.refreshToken, this.userId, this._orders);

  List<Order> get orders {
    return [..._orders.where((element) => element.deleted == false)];
  }

  Future<void> addOrder(
      String itemUrl, int retailer, int addressId, String note) async {
    //add order api
    try {
      final url = Uri.parse('$ORDER_API/create_order');
      final tokens = await api.getTokens();
      await api.api.postUri(url,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'access-token': '${tokens['accessToken']}',
          }),
          data: json.encode({
            'item_url': itemUrl,
            'retailer': retailer,
            'address_id': addressId,
            'note': note,
          }));
    } on DioError catch (error) {
      throw HttpException(error.response!.statusMessage!);
    }
    notifyListeners();
  }

  Order findById(int id) {
    return _orders.firstWhere((order) => id == order.id);
  }

  String? getTrackingNumber(int id) {
    return _orders.firstWhere((order) => id == order.id).trackingNumber;
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

  Address getAddressOfOrder(int orderId) {
    //TODO get address of order here
    return Address(
        id: '1',
        country: 'USA',
        state: 'Texas',
        city: 'Arizona',
        name: 'Hassan',
        addressLine1: 'First Street',
        addressLine2: 'B1');
  }

  bool cancelOrder(int orderId) {
    //TODO CANCEL ORDER API
    return true;
  }
}
