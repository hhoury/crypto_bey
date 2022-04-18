// ignore_for_file: prefer_const_constructors

import 'package:crypto_bey/screens/new_order_screen.dart';

import '../screens/my_account_screen.dart';
import '../screens/order_history_screen.dart';
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
      {'screen': MyAccountScreen(), 'title': 'My Account'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Order',
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          Navigator.of(context).pushNamed(NewOrderScreen.routeName);
        },
        child: Icon(
          Icons.add,
          size: 42,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _screens![_selectedScreenIndex]['screen'] as Widget,
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.history_outlined, size: 42),
              label: 'Orders History'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.person_rounded, size: 42),
              label: 'My Account'),
        ],
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        currentIndex: _selectedScreenIndex,
      ),
    );
  }
}
