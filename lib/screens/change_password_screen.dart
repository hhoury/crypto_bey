import 'package:flutter/material.dart';

import '../utils/helper_widgets.dart';

// ignore: use_key_in_widget_constructors
class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/change-password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(20),
              Text('Current Password',
                  style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(),
              addVerticalSpace(20),
              Text('New Password',
                  style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(),
              addVerticalSpace(20),
              Text('Confirm New Password',
                  style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(),
              addVerticalSpace(20),
              buttonContainer(ElevatedButton(
                  onPressed: () {}, child: padButtonText('Change Password')))
            ],
          ),
        ),
      ),
    );
  }
}
