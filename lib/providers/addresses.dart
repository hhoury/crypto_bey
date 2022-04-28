import 'package:flutter/material.dart';

import '../models/address.dart';

class Addresses with ChangeNotifier {
  final List<Address> _addresses = [
    Address(
        id: '123456',
        country: 'USA',
        name: 'John Doe',
        details: '1422 Larch St, Halifax CA B35-38I',
        unit: 'B2'),
    Address(
        id: '1234567',
        country: 'Lebanon',
        name: 'John Cena',
        details: '1422 Larch St, Halifax CA B35-38I St, Halifax CA B35-38I',
        unit: 'A2')
  ];

  List<Address> get addresses {
    return [..._addresses];
  }

  void addAddress(Address address) {
    //add address api
    address.id = DateTime.now().toString();
    _addresses.add(address);
    notifyListeners();
  }

  void editAddress(String id, Address newAddress) {
    final addressIndex = _addresses.indexWhere((element) => element.id == id);
    if (addressIndex >= 0) {
      _addresses[addressIndex] = newAddress;
    }
    notifyListeners();
  }

  Address findById(String id) {
    return _addresses.firstWhere((address) => id == address.id);
  }

  void deleteAddress(String id) {
    _addresses.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
