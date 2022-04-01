import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class MyAccountPage extends StatelessWidget {
  static const routeName = '/my-account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('My Account'),
      ),
    );
  }
}
