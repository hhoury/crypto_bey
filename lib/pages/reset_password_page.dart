import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ResetPasswordPage extends StatelessWidget {
  static const routeName = '/reset-password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: const [
              Text('Email Address'),
              TextField(),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(onPressed: null, child: Text('Send Reset Link'))
            ],
          )),
    );
  }
}
