// ignore_for_file: use_key_in_widget_constructors

import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../utils/input_helpers.dart';
import 'package:flutter/material.dart';
import '../screens/reset_password_screen.dart';
import '../screens/signup_screen.dart';
import '../utils/helper_widgets.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginForm = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  var _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  Future<void> _submitLogin() async {
    final isValid = _loginForm.currentState!.validate();
    if (!isValid) {
      return;
      // Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .login(_emailController.text, _passController.text);
      } catch (error) {
        showErrorDialog(context, 'Authentication Failed', error.toString());
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildAuthButtons() {
    return Column(
      children: [
        buttonContainer(ElevatedButton(
          onPressed: _submitLogin,
          child: padButtonText(text: 'LOGIN'),
          style: Theme.of(context).elevatedButtonTheme.style,
        )),
        addVerticalSpace(10),
        buttonContainer(ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
          },
          child: padButtonText(text: 'SIGN UP'),
          style: Theme.of(context).elevatedButtonTheme.style,
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _loginForm,
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
                    child: Text('Email',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  addVerticalSpace(10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
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
                  addVerticalSpace(15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Password',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  addVerticalSpace(10),
                  TextFormField(
                    controller: _passController,
                    textInputAction: TextInputAction.done,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ResetPasswordScreen.routeName);
                        },
                        child: const Text('Forgot Password?')),
                  ),
                  addVerticalSpace(30),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _buildAuthButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
