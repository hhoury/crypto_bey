// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          ClipRRect(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              width: 220,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Align(alignment: Alignment.centerLeft, child: Text('Email')),
          const TextField(),
          const Align(alignment: Alignment.centerLeft, child: Text('Password')),
          const TextField(),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: const Text('Forgot Password'))),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('LOGIN')),
          ElevatedButton(onPressed: () {}, child: const Text('SIGNUP')),
        ],
      ),
    ));
  }
}
