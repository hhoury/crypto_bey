import 'package:crypto_bey/providers/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import '../utils/helper_widgets.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _resetForm = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  var _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Something went wrong! '),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Okay!'))
              ],
            ));
  }

  Future<void> _submitResetPassword() async {
    final isValid = _resetForm.currentState!.validate();
    if (isValid) {
      try {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Auth>(context, listen: false)
            .resetPassword(_emailController.text);
      } catch (error) {
        showErrorDialog(context, 'Reset Failed!', error.toString());
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            'Please Check Email Sent to ${_emailController.text}',
            style: Theme.of(context).textTheme.button,
          )));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _resetForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Address',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  addVerticalSpace(10),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !EmailValidator.validate(value)) {
                        return 'Please Enter a Valid Email Address';
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
                          onPressed: _submitResetPassword,
                          child: padButtonText(text: 'Send Reset Link')))
                ],
              ),
            )),
      ),
    );
  }
}
