import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class PersonalInformationPage extends StatelessWidget {
  static const routeName = '/personal-information';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal information')),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            Text('Full Name'),
            TextField(),
            Text('Email'),
            TextField(),
            Text('Phone'),
            Row(
              children: [
                TextField(),
                TextField(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: Text('SUBMIT')),
          ],
        ),
      ),
    );
  }
}
