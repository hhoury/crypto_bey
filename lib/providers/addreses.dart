import 'package:flutter/material.dart';

import '../models/address.dart';

class Addresses with ChangeNotifier {
  final List<Address> _addresses = [];

  List<Address> get addresses {
    return [..._addresses];
  }

  void addAddress() {
    //add address api
    notifyListeners();
  }

  Address findById(String id) {
    return _addresses.firstWhere((address) => id == address.id);
  }
}
