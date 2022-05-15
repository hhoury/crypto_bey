import 'package:crypto_bey/models/http_exception.dart';
import 'package:hive/hive.dart';

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

  Future<void> getAddresses() async {
    try {
      final url = Uri.parse('$ADDRESS_API/get');
      var _userBox = await Hive.openBox('userBox');
      final _userData = json.decode(_userBox.get('userData', defaultValue: ''));

      if (_userData.toString().isEmpty) {
        throw HttpException('Something went wrong');
      }
      if (_userData['accessToken'].toString().isEmpty) {
        throw HttpException('Something went wrong');
      }
      final res = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${_userData['accessToken']}',
      });
      final extractedAddresses = json.decode(res.body) as Map<int, dynamic>;
      if (extractedAddresses == null) return;
      final List<Address> loadedAddress = [];
      extractedAddresses.forEach((addressId, addressData) {
        loadedAddress.add(Address(
          id: addressId,
          country: addressData['country'],
          name: addressData['name'],
          address: addressData['address'],
          unit: addressData['unit'],
        ));
      });
    } catch (error) {
      throw HttpException('Something went wrong!');
    }
  }

  Future<void> addAddress(Address address) async {
    //add address api

    try {
      final url = Uri.parse('$ADDRESS_API/create');
      var _userBox = await Hive.openBox('userBox');
      final _userData = json.decode(_userBox.get('userData', defaultValue: ''));

      if (_userData.toString().isEmpty) {
        throw HttpException('Something went wrong');
      }
      if (_userData['accessToken'].toString().isEmpty) {
        throw HttpException('Something went wrong');
      }
      final res = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${_userData['accessToken']}',
          },
          body: json.encode({
            "country": address.country,
            "city": address.state,
            "address": address.address,
            "unit": address.unit
          }));
      print(res.body);
      if (res.statusCode >= 400) {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> updateAddress(int id, Address newAddress) async {
    try {
      final url = Uri.parse('$ADDRESS_API/update/$id');
      var _userBox = await Hive.openBox('userBox');
      final _userData = json.decode(_userBox.get('userData', defaultValue: ''));
      final res = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${_userData['accessToken']}',
          },
          body: json.encode({
            "country": newAddress.country,
            "city": newAddress.state,
            "address": newAddress.address,
            "unit": newAddress.unit
          }));
      print(res.body);
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<Address> findById(int id) async {
    final url = Uri.parse('$ADDRESS_API/get/$id');
    var _userBox = Hive.openBox('userBox');
    final _userData =
        await json.decode(_userBox.get('userData', defaultValue: ''));
    final res = http.post(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_userData['accessToken']}',
    });
    // var address = json.decode(res.body);
    return _addresses.firstWhere((address) => id == address.id);
  }

  void deleteAddress(int id) async {
    final url = Uri.parse('$ADDRESS_API/delete/$id');
    var _userBox = await Hive.openBox('userBox');
    final _userData = json.decode(_userBox.get('userData', defaultValue: ''));
    final res = http.delete(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_userData['accessToken']}',
    });
    notifyListeners();
  }
}
