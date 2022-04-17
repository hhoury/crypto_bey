import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class PrivacyScreen extends StatelessWidget {
  static const routeName = '/privacy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy and Security'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: const [
            ElevatedButton(onPressed: null, child: Text('Change Password')),
            ElevatedButton(onPressed: null, child: Text('Reset Password')),
            ElevatedButton(onPressed: null, child: Text('Log Out')),
          ],
        ),
      ),
    );
  }
}
