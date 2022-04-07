import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class PersonalInformationPage extends StatelessWidget {
  static const routeName = '/personal-information';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal information')),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            const Text('Full Name'),
            const TextField(),
            const Text('Email'),
            const TextField(),
            const Text('Phone'),
            Row(
              children: const [
                TextField(),
                TextField(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('SUBMIT')),
          ],
        ),
      ),
    );
  }
}
