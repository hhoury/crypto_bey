import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class PrivacyPage extends StatelessWidget {
  static const routeName = '/privacy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy and Security'),
      ),
    );
  }
}
