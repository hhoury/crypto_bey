import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/http_exception.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _refreshToken = '';
  String _accessToken = '';
  final String _userId = '';
  Timer? _authTimer;

  bool get isAuth {
    return token.isNotEmpty;
  }

  String get token {
    if (_refreshToken.isNotEmpty) {
      return _refreshToken;
    }
    return '';
  }

  String get userId {
    return _userId;
  }

  Future<void> signup(String fName, String lName, String phnNumber,
      String email, String password) async {
    try {
      final url = Uri.parse('$USER_API/create');
      final response = await http.post(url,
          headers: API_HEADER,
          body: json.encode({
            'first_name': fName,
            'last_name': lName,
            'phone_number': phnNumber,
            'email': email,
            'password': password,
          }));
      final responseData = json.decode(response.body);

      if (responseData["success"] != null && responseData["success"]) {
        return;
      }

      if (responseData["detail"]["errorMessage"] != null) {
        throw HttpException(responseData["detail"]["errorMessage"]);
      } else {
        //after registration success
        // _refreshToken = responseData['refresh_token'];
        // _accessToken = responseData['access_token'];
        // notifyListeners();
        // var userBox = await Hive.openBox('userBox');
        // final userData = json.encode({
        //   'accessToken': _accessToken,
        //   'refreshToken': _refreshToken,
        // });
        // userBox.put('userData', userData);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final url = Uri.parse('$USER_API/login');
      final response = await http.post(url,
          headers: API_HEADER,
          body: json.encode({
            'email': email,
            'password': password,
          }));
      final responseData = json.decode(response.body);
      if (response.statusCode >= 400) {
        throw HttpException(
            responseData["detail"]["error_description"].toString());
      }

      _refreshToken = responseData['refresh_token'];
      _accessToken = responseData['access_token'];

      var userBox = await Hive.openBox('userBox');
      final userData = json.encode({
        'accessToken': _accessToken,
        'refreshToken': _refreshToken,
      });
      userBox.put('userData', userData);
      notifyListeners();
      tryAutoLogin();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    final url = Uri.parse('$USER_API/update_password');
    try {
      final response = await http.put(url,
          headers: {
            'access-token': _accessToken,
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(
            {'current_password': currentPassword, 'new_password': newPassword},
          ));
      if (response.statusCode < 400) {
        return;
      }
      final responseData = json.decode(response.body);
      if (responseData.toString().isEmpty) return;
      if (response.statusCode >= 400) {
        throw HttpException(
            responseData["detail"]["error_description"].toString());
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final url = Uri.parse('$USER_API/logout');
    final res = await http.post(url, headers: {
      'refresh-token': _refreshToken,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    // final responseData = json.decode(response.body);

    // if (_authTimer != null) {
    //   _authTimer!.cancel();
    //   _authTimer = null;
    // }
    if (res.statusCode < 400) {
      _refreshToken = '';
      _accessToken = '';
      var userBox = await Hive.openBox('userBox');
      userBox.delete('userData');
      userBox.clear();
      notifyListeners();
    } else {
      throw HttpException('Logout Failed!');
    }
  }

  Future<void> resetPassword(String email) async {
    final url = Uri.parse('$USER_API/reset_password');
  }

  Future<bool> tryAutoLogin() async {
    var userBox = await Hive.openBox('userBox');
    // await userBox.clear();
    if (!userBox.containsKey('userData')) {
      return false;
    } else {
      final userData = json.decode(userBox.get('userData', defaultValue: ''));
      if (userData.toString().isEmpty) {
        return false;
      } else {
        _refreshToken = userData['refreshToken'] ?? '';
        _accessToken = userData['accessToken'] ?? '';
        notifyListeners();
        return true;
      }
    }
  }

//set a timer to execute code when time expired
  //use dart:async library
  // void _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer!.cancel();
  //   }
  //   final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }
}
