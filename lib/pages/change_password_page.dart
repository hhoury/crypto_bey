import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ChangePasswordPage extends StatelessWidget {
  static const routeName = '/change-password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: const [
            Text('Current Password'),
            TextField(),
            Text('New Password'),
            TextField(),
            Text('Confirm New Password'),
            TextField(),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: null, child: Text('Change Password'))
          ],
        ),
      ),
    );
  }
}
