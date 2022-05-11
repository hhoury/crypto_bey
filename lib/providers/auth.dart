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

      if (responseData['error'] != null || !responseData["success"]) {
        throw HttpException(responseData['error']['message']);
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
      if (responseData['error'] != null || !responseData["success"]) {
        throw HttpException(responseData['error']['message']);
      } else {
        _refreshToken = responseData['refresh_token'];
        _accessToken = responseData['access_token'];
        notifyListeners();
        var userBox = await Hive.openBox('userBox');
        final userData = json.encode({
          'accessToken': _accessToken,
          'refreshToken': _refreshToken,
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
      if (_authTimer != null) {
        _authTimer!.cancel();
        _authTimer = null;
      }
      var userBox = await Hive.openBox('userBox');
      await userBox.delete('userData');
      await userBox.clear();
      notifyListeners();
    }
  }

  Future<bool> tryAutoLogin() async {
    var userBox = await Hive.openBox('userBox');
    await userBox.clear();
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
