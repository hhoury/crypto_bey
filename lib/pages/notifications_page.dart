import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class NotificationsPage extends StatelessWidget {
  static const routeName = '/notifications';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text('Receive Order Changes Notifications'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Email'),
                Switch(value: false, onChanged: null)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Text (SMS)'),
                Switch(value: false, onChanged: null)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('App Notifications'),
                Switch(value: false, onChanged: null)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
