// ignore_for_file: prefer_const_constructors

import 'package:crypto_bey/pages/my_account_page.dart';
import 'package:crypto_bey/pages/order_history_page.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TabsPage extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List<Map<String, Object>>? _pages;

  int _selectedPageIndex = 0;

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': OrderHistoryPage(), 'title': 'Orders History'},
      {'page': MyAccountPage(), 'title': 'My Account'}
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
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
