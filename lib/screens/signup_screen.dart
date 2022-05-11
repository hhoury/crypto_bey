import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _phoneCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _phoneCodeController.dispose();
    _phoneNumberController.dispose();
  }

  void _submitSignup() {
    final isValid = _signupForm.currentState!.validate();
    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).backgroundColor,
        content: Text(
          'Please check the link sent to your email',
          style: Theme.of(context).textTheme.button,
        ),
      ));
    }
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
                  inputLabel(context, 'Full Name'),
                  addVerticalSpace(10),
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Full Name';
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
                  buttonContainer(ElevatedButton(
                      onPressed: () => _submitSignup(),
                      child: padButtonText(text: 'SIGNUP'))),
                  addVerticalSpace(10),
                  buttonContainer(
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: secondaryButtonColor),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: padButtonText(text: 'I HAVE AN ACCOUNT'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
