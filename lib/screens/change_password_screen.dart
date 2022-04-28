import 'package:flutter/material.dart';

import '../utils/helper_widgets.dart';
import '../utils/input_helpers.dart';

// ignore: use_key_in_widget_constructors
class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _changePasswordForm = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _cconfirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _cconfirmNewPasswordController.dispose();
  }

  void _changePasswordSubmit() {
    final isValid = _changePasswordForm.currentState!.validate();
    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).backgroundColor,
          content: Text(
            'Your Password has been changed',
            style: Theme.of(context).textTheme.button,
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _changePasswordForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputLabel(context, 'Current Password'),
                addVerticalSpace(10),
                TextFormField(
                  controller: _currentPasswordController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !validatePassword(value)) {
                      return 'Please Enter a Valid Password';
                    } else {
                      return null;
                    }
                  },
                ),
                addVerticalSpace(20),
                inputLabel(context, 'New Password'),
                addVerticalSpace(10),
                TextFormField(
                  controller: _newPasswordController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !validatePassword(value)) {
                      return 'Please Enter a Valid Password';
                    } else {
                      return null;
                    }
                  },
                ),
                addVerticalSpace(20),
                inputLabel(context, 'Confirm New Password'),
                addVerticalSpace(10),
                TextFormField(
                  controller: _cconfirmNewPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !validatePassword(value)) {
                      return 'Please Enter a Valid Password';
                    } else if (value != _newPasswordController.text) {
                      return 'Confirm Password does not match Password';
                    } else {
                      return null;
                    }
                  },
                ),
                addVerticalSpace(20),
                buttonContainer(ElevatedButton(
                    onPressed: () => _changePasswordSubmit(),
                    child: padButtonText('Change Password')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
