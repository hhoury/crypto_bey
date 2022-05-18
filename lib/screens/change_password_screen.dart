import '../theme/theme_constants.dart';
import 'package:dio/dio.dart';

import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final _confirmNewPasswordController = TextEditingController();
  var _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
  }

  Future<void> _changePasswordSubmit() async {
    if (_currentPasswordController.text == _newPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(
            'Current and New Password can\'t be the same',
            style: Theme.of(context).textTheme.button,
            textAlign: TextAlign.center,
          )));
      return;
    }
    final isValid = _changePasswordForm.currentState!.validate();
    if (isValid) {
      try {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Auth>(context, listen: false).changePassword(
            _currentPasswordController.text, _newPasswordController.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: purpleColor,
            content: Text(
              'Your Password has been changed',
              style: Theme.of(context).textTheme.button,
              textAlign: TextAlign.center,
            )));
        Navigator.of(context).pop();
      } on DioError catch (error) {
        showErrorDialog(context, 'Something Went Wrong',
            error.response?.data['detail']['error_description']);
      } catch (error) {
        showErrorDialog(context, 'Something Went Wrong', error.toString());
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    controller: _confirmNewPasswordController,
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
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : buttonContainer(ElevatedButton(
                          onPressed: _changePasswordSubmit,
                          child: padButtonText(text: 'Change Password')))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
