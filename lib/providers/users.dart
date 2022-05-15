import '../models/user.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  final List<User> _users = [];

  List<User> get users {
    return [..._users.where((element) => element.deleted == false)];
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
