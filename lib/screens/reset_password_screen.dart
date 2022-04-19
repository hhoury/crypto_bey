import '../utils/helper_widgets.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ResetPasswordScreen extends StatelessWidget {
  static const routeName = '/reset-password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.all(10),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(20),
                  Text(
                    'Email Address',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  addVerticalSpace(10),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  addVerticalSpace(20),
                  buttonContainer(ElevatedButton(
                      onPressed: () {}, child: padButtonText('Send Reset Link')))
                ],
              ),
            )),
      ),
    );
  }
}
