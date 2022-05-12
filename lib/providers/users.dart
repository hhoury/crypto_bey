import 'dart:convert';

import '../constants/api_constants.dart';

import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class Users with ChangeNotifier {
  final List<User> _users = [];

  List<User> get users {
    return [..._users.where((element) => element.deleted == false)];
  }

  void getUserProfile() async {
    var userBox = Hive.box('userBox');
    if (userBox.containsKey('userData')) {
      final userData = json.decode(userBox.get('userData', defaultValue: ''));
      final url = Uri.parse('$USER_API/profile');
      final response = http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userData['accessToken']}',
      });
      print(response);
    }
  }

  void updateUser(int id, User updatedUser) {
    final userIndex = _users.indexWhere((element) => element.id == id);
    if (userIndex >= 0) {
      _users[userIndex] = updatedUser;
    }
    notifyListeners();
  }

  void deleteUser(int userId) {
    final userIndex = _users.indexWhere((element) => element.id == userId);
    if (userIndex >= 0) {
      _users[userIndex].deleted = true;
    }
    notifyListeners();
  }
}
