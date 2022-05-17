import 'dart:async';
import 'dart:convert';
import 'package:crypto_bey/core/services/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';
import '../models/http_exception.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _refreshToken = '';
  String _accessToken = '';
  final String _userId = '';
  Timer? _authTimer;
  final api = Api();

  final _storage = const FlutterSecureStorage();

  bool get isAuth {
    return refreshToken.isNotEmpty;
  }

  String get refreshToken {
    if (_refreshToken.isNotEmpty) {
      return _refreshToken;
    }
    return '';
  }

  String get accessToken {
    if (_accessToken.isNotEmpty) {
      return _accessToken;
    }
    return '';
  }

  String get userId {
    return _userId;
  }

  // Future<void> refreshAccessToken() async {
  //   try {
  //     final url = Uri.parse('$USER_API/refresh_access_token');
  //     var userBox = await Hive.openBox('userBox');
  //     var userData = json.decode(userBox.get('userData', defaultValue: ''));
  //     final response = await http.get(url, headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'refresh-token': '${userData['refreshToken']}',
  //     });
  //     final responseData = json.decode(response.body);
  //     if (response.statusCode >= 400) {
  //       throw HttpException(
  //           responseData["detail"]["error_description"].toString());
  //     }

  //     _refreshToken = responseData['refresh_token'];
  //     _accessToken = responseData['access_token'];

  //     userData = json.encode({
  //       'accessToken': _accessToken,
  //       'refreshToken': _refreshToken,
  //     });
  //     userBox.put('userData', userData);
  //     notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<void> signup(String fName, String lName, String countryCode,
      String phnNumber, String email, String password) async {
    try {
      final url = Uri.parse('$USER_API/create');
      final res = await api.api.postUri(url,
          data: json.encode({
            'first_name': fName,
            'last_name': lName,
            'country_code': countryCode,
            'phone_number': phnNumber,
            'email': email,
            'password': password,
          }));
      final responseData = res.data;
      if (responseData["success"] != null && responseData["success"]) {
        return;
      }
      if (responseData["detail"]["errorMessage"] != null) {
        throw HttpException(responseData["detail"]["errorMessage"]);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final url = Uri.parse('$USER_API/login');
      final response = await api.api.postUri(url,
          options: Options(headers: API_HEADER),
          data: json.encode({
            'email': email,
            'password': password,
          }));
      final responseData = response.data;
      if (response.statusCode! >= 400) {
        throw HttpException(
            responseData["detail"]["error_description"].toString());
      }
      _refreshToken = responseData['refresh_token'];
      _accessToken = responseData['access_token'];
      await api.removeTokens();
      await api.saveTokens(_accessToken, _refreshToken);
      notifyListeners();
      tryAutoLogin();
    } on DioError catch (error) {
      throw HttpException(error.response?.data['detail']['error_description'] ??
          'Something Went Wrong!');
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    final url = Uri.parse('$USER_API/update_password');
    try {
      var tokens = await api.getTokens();
      _accessToken = tokens['accessToken'] ?? '';
      final response = await api.api.putUri(url,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'access-token': _accessToken,
          }),
          data: json.encode(
            {'current_password': currentPassword, 'new_password': newPassword},
          ));
    } on DioError catch (error) {
      throw HttpException(error.response?.data['detail']['error_description']);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final url = Uri.parse('$USER_API/logout');
    final res = await api.api.postUri(url,
        options: Options(headers: {
          'refresh-token': _refreshToken,
          'Content-type': 'application/json',
          'Accept': 'application/json',
        }));
    // final responseData = json.decode(response.body);
    // if (_authTimer != null) {
    //   _authTimer!.cancel();
    //   _authTimer = null;
    // }
    _refreshToken = '';
    _accessToken = '';
    await api.removeTokens();
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      final url = Uri.parse('$USER_API/reset_password');
      final response = await api.api.putUri(url,
          options: Options(headers: API_HEADER),
          data: {'request_password_reset': true, 'email': email});
      print(response);
    } on DioError catch (error) {
      throw HttpException(error.response?.data['detail']['error_description']);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    if (!await _storage.containsKey(key: 'refreshToken')) {
      return false;
    } else {
      var tokens = await api.getTokens();
      _refreshToken = tokens['refreshToken'] ?? '';
      _accessToken = tokens['accessToken'] ?? '';
      if (_refreshToken.isEmpty) {
        return false;
      }
      notifyListeners();
      return true;
    }
  }

  Future<dynamic> getUserProfile() async {
    try {
      var tokens = await api.getTokens();
      _refreshToken = tokens['refreshToken'] ?? '';
      _accessToken = tokens['accessToken'] ?? '';
      final url = Uri.parse('$USER_API/profile');
      final res = await api.api.getUri(url,
          options: Options(
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'access-token': _accessToken,
            },
          ));
      if (res.statusCode! < 300) {
        final resData = res.data;
        return resData;
      }
    } on DioError catch (error) {
      throw HttpException(
          error.response?.data['detail']['error_description'].toString() ??
              'Something went wrong!');
    }

    return null;
  }

  Future<void> updateUserProfile(String fName, String lName, String countryCode,
      String phoneNumber) async {
    try {
      final tokens = await api.getTokens();
      final url = Uri.parse('$USER_API/update_info');
      final response = await api.api.putUri(url,
          options: Options(
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'access-token': '$tokens["accessToken"]',
            },
            contentType: 'application/json',
          ),
          data: {
            'first_name': fName,
            'last_name': lName,
            'country_code': countryCode,
            'phone_number': phoneNumber
          });
      print(response);
    } on DioError catch (error) {
      throw HttpException(error.response?.data['detail']['error_description']);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> resendVerificationEmail(String email) async {
    try {
      final url = Uri.parse('$USER_API/resend-verification-email');
      final response =
          api.api.putUri(url, options: Options(headers: API_HEADER));
    } on DioError catch (error) {
      throw HttpException(error.response?.data['detail']['error_description']);
    } catch (error) {
      rethrow;
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
