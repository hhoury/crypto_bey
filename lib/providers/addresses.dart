import 'dart:math';

import 'package:flutter/material.dart';

import '../models/address.dart';

class Addresses with ChangeNotifier {
  final List<Address> _addresses = [];
  final String refreshToken = '';

  List<Address> get addresses {
    return [..._addresses];
  }

  void addAddress(Address address) {
    //add address api
    address.id = Random().nextInt(100);
    _addresses.add(address);
    notifyListeners();
  }

  void updateAddress(int id, Address newAddress) {
    final addressIndex = _addresses.indexWhere((element) => element.id == id);
    if (addressIndex >= 0) {
      _addresses[addressIndex] = newAddress;
    }
    notifyListeners();
  }

  Address findById(int id) {
    return _addresses.firstWhere((address) => id == address.id);
  }

  void deleteAddress(int id) {
    final addressIndex = _addresses.indexWhere((element) => element.id == id);
    if (addressIndex >= 0) {
      _addresses[addressIndex].deleted = true;
    }
    notifyListeners();
  }
}
