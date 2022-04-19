import 'package:flutter/material.dart';

import '../models/address.dart';

class Addresses with ChangeNotifier {
  final List<Address> _addresses = [
    Address(id: '123456', receiver: 'John Doe', address: '1422 Larch St, Halifax CA B35-38I'),
    Address(id: '123456', receiver: 'John Cena', address: '1422 Larch St, Halifax CA B35-38I St, Halifax CA B35-38I'),
  ];

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
