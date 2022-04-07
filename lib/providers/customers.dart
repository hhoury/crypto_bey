import 'package:crypto_bey/models/customer.dart';
import 'package:flutter/material.dart';

class Customers with ChangeNotifier {
  final List<Customer> _customers = [];

  List<Customer> get customers {
    return [..._customers];
  }

  void addOCustomer() {
    //add order api
    notifyListeners();
  }

  Customer findById(String id) {
    return _customers.firstWhere((customer) => id == customer.id);
  }
}
