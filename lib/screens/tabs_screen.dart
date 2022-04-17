// ignore_for_file: prefer_const_constructors

import 'package:crypto_bey/screens/my_account_screen.dart';
import 'package:crypto_bey/screens/order_history_screen.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>>? _screens;

  int _selectedScreenIndex = 0;

  void _selectScreen(index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _screens = [
      {'screen': OrderHistoryScreen(), 'title': 'Orders History'},
      {'screen': MyAccountScreen(), 'title': 'My Account'}
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.watch_later),
              label: 'Orders History'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.person_rounded),
              label: 'My Account'),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        currentIndex: _selectedScreenIndex,
      ),
    );
  }
}
