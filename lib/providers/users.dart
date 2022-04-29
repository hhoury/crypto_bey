import '../models/user.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  final List<User> _users = [
    User(
      id: 1,
      firstName: 'firstName',
      lastName: 'lastName',
      email: 'email@email.com',
      emailVerified: true,
      phoneNumber: '0096170040404',
      dateCreated: DateTime.now(),
    ),
    User(
      id: 2,
      firstName: 'second user',
      lastName: 'lastName',
      email: 'second@email.com',
      emailVerified: true,
      phoneNumber: '001122334455',
      dateCreated: DateTime.now(),
    ),
  ];

  List<User> get users {
    return [..._users.where((element) => element.deleted == false)];
  }

  void addUser(User user) {
    //add order api
    _users.add(user);
    notifyListeners();
  }

  User findById(int id) {
    return _users.firstWhere((user) => id == user.id);
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
