import '../core/services/api.dart';
import '../models/http_exception.dart';
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
    // Future.delayed(Duration.zero).then(
    //   (value) {
    // getAddresses();
    // },
    // );
  }

  List<Address> get addresses {
    return [..._addresses];
  }

  Future<dynamic> getAddresses() async {
    try {
      final url = Uri.parse('$ADDRESS_API/get');
      final tokens = await api.getTokens();
      final res = await api.api.getUri(
        url,
        options: Options(headers: {
          'Accept': 'application/json',
          'access-token': '${tokens['accessToken']}',
        }, contentType: 'application/json'),
      );
      final extractedAddresses = res.data['addresses'] as List<dynamic>;
      if (extractedAddresses.isEmpty) return;
      final List<Address> loadedAddress = [];
      for (var addressData in extractedAddresses) {
        loadedAddress.add(Address(
          id: addressData['id'],
          country: addressData['country'],
          state: addressData['state'],
          city: addressData['city'],
          name: addressData['name'],
          addressLine1: addressData['line1'],
          addressLine2: addressData['line2'],
        ));
      }
      _addresses = loadedAddress;
      return _addresses;
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

      await api.api.postUri(url,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'access-token': '${tokens['accessToken']}',
          }),
          data: json.encode({
            'name': address.name,
            'country': address.country,
            'state': address.state,
            'city': address.city,
            'line1': address.addressLine1,
            'line2': address.addressLine2
          }));
    } on DioError catch (error) {
      throw HttpException(error.response?.data['detail']['msg']);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> updateAddress(String id, Address newAddress) async {
    try {
      final url = Uri.parse('$ADDRESS_API/update/$id');
      final tokens = await api.getTokens();

      await api.api.postUri(url,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'access-token': '${tokens['accessToken']}',
          }),
          data: json.encode({
            'name': newAddress.name,
            'country': newAddress.country,
            'state': newAddress.state,
            'city': newAddress.city,
            'line1': newAddress.addressLine1,
            'line2': newAddress.addressLine2
          }));
    } on DioError catch (error) {
      throw HttpException(error.response?.data['error']['error_description']);
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  // Future<Address> findById(String id) async {
  //   final url = Uri.parse('$ADDRESS_API/get/$id');
  //   final tokens = await api.getTokens();
  //   // final _userData =
  //   //     await json.decode(_userBox.get('userData', defaultValue: ''));
  //   // final res = http.post(url, headers: {
  //   //   'Content-type': 'application/json',
  //   //   'Accept': 'application/json',
  //   //   'Authorization': 'Bearer ${_userData['accessToken']}',
  //   // });
  //   // var address = json.decode(res.body);
  //   return _addresses.firstWhere((address) => id == address.id);
  // }

  void deleteAddress(String id) async {
    try {
      final url = Uri.parse('$ADDRESS_API/delete/$id');
      final tokens = await api.getTokens();
      _addresses.removeWhere(
        (element) => element.id == id,
      );
      await api.api.deleteUri(url,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'access-token': '${tokens['accessToken']}',
          }));

      notifyListeners();
    } on DioError catch (error) {
      throw HttpException(error.response?.data['detail']['error_description']);
    } catch (error) {
      rethrow;
    }
  }
}
