import 'package:crypto_bey/core/services/api.dart';
import 'package:crypto_bey/models/http_exception.dart';
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/address.dart';

class Addresses with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Address> _addresses = [];
  String refreshToken = '';
  String userId = '';
  final api = Api();
  Addresses(this.refreshToken, this.userId, this._addresses) {
    getAddresses();
  }

  List<Address> get addresses {
    return [..._addresses];
  }

  Future<void> getAddresses() async {
    try {
      final url = Uri.parse('$ADDRESS_API/get');
      final tokens = await api.getTokens();
      final res = await api.api.getUri(
        url,
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${tokens['accessToken']}',
        }, contentType: 'application/json'),
      );
      final extractedAddresses = res.data as Map<int, dynamic>;
      if (extractedAddresses == null) return;
      final List<Address> loadedAddress = [];
      extractedAddresses.forEach((addressId, addressData) {
        loadedAddress.add(Address(
          id: addressId,
          country: addressData['country'],
          state: addressData['state'],
          city: addressData['city'],
          name: addressData['name'],
          addressLine1: addressData['line1'],
          addressLine2: addressData['line2'],
        ));
      });
    } on DioError catch (error) {
      throw HttpException(error.response?.data['detail']['error_description']);
    } catch (error) {
      throw HttpException('Something went wrong!');
    }
  }

  Future<void> addAddress(Address address) async {
    try {
      final url = Uri.parse('$ADDRESS_API/create');
      final tokens = await api.getTokens();

      final res = await api.api.postUri(url,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${tokens['accessToken']}',
          }),
          data: json.encode({
            'country': address.country,
            'state': address.state,
            'city': address.city,
            'line1': address.addressLine1,
            'line2': address.addressLine2
          }));
      if (res.data.statusCode >= 400) {
        throw Error();
      }
    } on DioError catch (error) {
      throw HttpException(error.response?.data);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> updateAddress(int id, Address newAddress) async {
    try {
      final url = Uri.parse('$ADDRESS_API/update/$id');
      final tokens = await api.getTokens();

      final res = await api.api.postUri(url,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${tokens['accessToken']}',
          }),
          data: json.encode({
            'country': newAddress.country,
            'state': newAddress.state,
            'city': newAddress.city,
            'line1': newAddress.addressLine1,
            'line2': newAddress.addressLine2
          }));
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<Address> findById(int id) async {
    final url = Uri.parse('$ADDRESS_API/get/$id');
    final tokens = await api.getTokens();
    // final _userData =
    //     await json.decode(_userBox.get('userData', defaultValue: ''));
    // final res = http.post(url, headers: {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer ${_userData['accessToken']}',
    // });
    // var address = json.decode(res.body);
    return _addresses.firstWhere((address) => id == address.id);
  }

  void deleteAddress(int id) async {
    final url = Uri.parse('$ADDRESS_API/delete/$id');
    final tokens = await api.getTokens();
    final res = await api.api.deleteUri(url,
        options: Options(headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${tokens['accessToken']}',
        }));
    notifyListeners();
  }
}
