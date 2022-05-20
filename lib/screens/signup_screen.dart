// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';
import '../screens/login_screen.dart';
import '../theme/theme_constants.dart';
import '../utils/helper_widgets.dart';
import '../utils/input_helpers.dart';

// ignore: use_key_in_widget_constructors
class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signupForm = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _phoneCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  var _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _phoneCodeController.dispose();
    _phoneNumberController.dispose();
  }

  Future<void> _submitSignup() async {
    final isValid = _signupForm.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).signup(
          _firstNameController.text,
          _lastNameController.text,
          _phoneCodeController.text,
          _phoneNumberController.text,
          _emailController.text,
          _passController.text,
        );
      } on HttpException catch (error) {
        showErrorDialog(context, 'Registration Failed', error.message);
        setState(() {
          _isLoading = false;
        });
        return;
      } catch (error) {
        showErrorDialog(
            context, 'Registration Failed', 'Please try again later.');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: purpleColor,
        content: Text(
          'Please check the link sent to your email',
          style: Theme.of(context).textTheme.button,
          textAlign: TextAlign.center,
        ),
      ));
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  Widget _buildButtons() {
    return Column(
      children: [
        buttonContainer(ElevatedButton(
            onPressed: _submitSignup, child: padButtonText(text: 'SIGNUP'))),
        addVerticalSpace(10),
        buttonContainer(
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: secondaryButtonColor),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: padButtonText(text: 'I HAVE AN ACCOUNT'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _signupForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/logop.png',
                          fit: BoxFit.cover,
                          width: 80,
                          height: 60,
                        ),
                      ),
                      Text('Crypto Bey',
                          style: Theme.of(context).textTheme.headline1)
                    ],
                  ),
                  addVerticalSpace(20),
                  inputLabel(context, 'First Name'),
                  addVerticalSpace(10),
                  TextFormField(
                    controller: _firstNameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your First Name';
                      }
                      return null;
                    },
                  ),
                  addVerticalSpace(20),
                  inputLabel(context, 'Last Name'),
                  addVerticalSpace(10),
                  TextFormField(
                    controller: _lastNameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Last Name';
                      }
                      return null;
                    },
                  ),
                  addVerticalSpace(20),
                  inputLabel(context, 'Phone Number'),
                  addVerticalSpace(10),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration: const InputDecoration(counterText: ''),
                          maxLength: 3,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          controller: _phoneCodeController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Phone Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      addHorizontalSpace(5),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: _phoneNumberController,
                          decoration: const InputDecoration(counterText: ''),
                          maxLength: 15,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Phone Number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(20),
                  inputLabel(context, 'Email'),
                  addVerticalSpace(10),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
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
                  addVerticalSpace(20),
                  inputLabel(context, 'Password'),
                  addVerticalSpace(10),
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    controller: _passController,
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
                  inputLabel(context, 'Password Confirmation'),
                  addVerticalSpace(10),
                  TextFormField(
                    controller: _confirmPassController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !validatePassword(value)) {
                        return 'Please Enter a Valid Password';
                      } else if (value != _passController.text) {
                        return 'Confirm Password does not match Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  addVerticalSpace(30),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _buildButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
