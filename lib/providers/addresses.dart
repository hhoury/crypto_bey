import '../constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/address.dart';

class Addresses with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Address> _addresses = [];
  String refreshToken = '';
  String userId = '';

  Addresses(this.refreshToken, this.userId, this._addresses);

  List<Address> get addresses {
    return [..._addresses];
  }

  Future<void> addAddress(Address address) async {
    //add address api
    final url = Uri.parse('$ADDRESS_API/create');

    try {
      final res = await http.post(url,
          body: json.encode({
            "country": address.country,
            "city": address.state,
            "address": address.address,
            "unit": address.unit
          }));
    } catch (e) {
      rethrow;
    }
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
