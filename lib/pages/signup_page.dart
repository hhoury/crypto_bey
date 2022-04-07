import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SignUpPage extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [Image.asset('logo'), const Text('Crypto Bey')],
            ),
            const SizedBox(height: 20),
            const Text('Full Name'),
            const TextField(),
            const Text('Phone Number'),
            Row(
              children: const [
                TextField(),
                TextField(),
              ],
            ),
            const Text('Email'),
            const TextField(),
            const Text('Password'),
            const TextField(),
            const Text('Password Confirmation'),
            const TextField(),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('SIGNUP')),
            ElevatedButton(
                onPressed: () {}, child: const Text('I HAVE AN ACCOUNT')),
          ],
        ),
      ),
    );
  }
}
