// ignore_for_file: use_key_in_widget_constructors

import 'package:crypto_bey/screens/reset_password_screen.dart';
import 'package:crypto_bey/screens/signup_screen.dart';
import 'package:crypto_bey/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/helper_widgets.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 50, 15, 5),
        child: Column(
          children: [
            Container(
              width: 300,
              height: 280,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Image.asset(
                'assets/images/logop.png',
                fit: BoxFit.cover,
                width: 200,
                height: 200,
                // semanticsLabel: 'Crypto Bey Logo',
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child:
                  Text('Email', style: Theme.of(context).textTheme.labelMedium),
            ),
            addVerticalSpace(10),
            TextFormField(),
            addVerticalSpace(15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Password',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
            addVerticalSpace(10),
            TextFormField(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ResetPasswordScreen.routeName);
                  },
                  child: const Text('Forgot Password')),
            ),
            addVerticalSpace(100),
            buttonContainer(ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              child: padButtonText('LOGIN'),
              style: Theme.of(context).elevatedButtonTheme.style,
            )),
            addVerticalSpace(10),
            buttonContainer(
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                },
                child: padButtonText('SIGN UP'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
