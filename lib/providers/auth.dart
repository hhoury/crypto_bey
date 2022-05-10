import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_bey/constants/api_constants.dart';
import 'package:crypto_bey/models/http_exception.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _refreshToken = '';
  String _accessToken = '';
  DateTime? _refreshExpiryDate;
  String _userId = '';
  Timer? _authTimer;

  bool get isAuth {
    return token.isNotEmpty;
  }

  String get token {
    if (_refreshExpiryDate != null &&
        _refreshExpiryDate!.isAfter(DateTime.now()) &&
        _refreshToken.isNotEmpty) {
      return _refreshToken;
    }
    return '';
  }

  String get userId {
    return _userId;
  }

  Future<void> _login(String email, String password) async {
    try {
      final url = Uri.parse('$USER_API/login');
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      } else {
        _refreshToken = responseData['refresh_token'];
        _accessToken = responseData['access_token'];
        _userId = responseData['userId'];
        _refreshExpiryDate = DateTime.now().add(Duration(
          seconds: int.parse(
              responseData['refresh_expires_in'] ?? 2628000), //month in seconds
        ));
        // _autoLogout();
        notifyListeners();
        var userBox = await Hive.openBox('userBox');
        final userData = json.encode({
          'accessToken': _accessToken,
          'refreshToken': _refreshToken,
          'userId': _userId,
          'refreshExpiryDate': _refreshExpiryDate?.toIso8601String(),
        });
        userBox.put('userData', userData);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final url = Uri.parse('$USER_API/logout');
    final response =
        await http.post(url, headers: {'refresh-token': _refreshToken});
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      _refreshToken = '';
      _accessToken = '';
      _userId = '';
      _refreshExpiryDate = null;
      if (_authTimer != null) {
        _authTimer!.cancel();
        _authTimer = null;
      }
      notifyListeners();
      var userBox = await Hive.openBox('userBox');
      userBox.delete('userData');
    }
  }
}
