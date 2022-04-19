import 'package:crypto_bey/screens/change_password_screen.dart';
import 'package:crypto_bey/screens/reset_password_screen.dart';
import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_manager.dart';

// ignore: use_key_in_widget_constructors
class PrivacyScreen extends StatelessWidget {
  static const routeName = '/privacy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy and Security'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              addVerticalSpace(30),
              buttonContainer(ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
                },
                child: padButtonText('Change Password'),
                style: Theme.of(context).elevatedButtonTheme.style,
              )),
              addVerticalSpace(20),
              buttonContainer(ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
                },
                child: padButtonText('Reset Password'),
              )),
              addVerticalSpace(20),
              buttonContainer(ElevatedButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
                child: padButtonText('Log Out'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
