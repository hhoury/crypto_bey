import 'package:crypto_bey/utils/helper_widgets.dart';
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
          children: [
            addVerticalSpace(30),
            buttonContainer(ElevatedButton(
              onPressed: () {},
              child: padButtonText('Change Password'),
              style: Theme.of(context).elevatedButtonTheme.style,
            )),
            addVerticalSpace(20),
            buttonContainer(ElevatedButton(
              onPressed: () {},
              child: padButtonText('Reset Password'),
              // style: Theme.of(context).elevatedButtonTheme.style,
            )),
            addVerticalSpace(20),
            buttonContainer(ElevatedButton(
              onPressed: () {},
              child: padButtonText('Log Out'),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ))
          ],
        ),
      ),
    );
  }
}
