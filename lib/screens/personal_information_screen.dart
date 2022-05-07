import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/helper_widgets.dart';

// ignore: use_key_in_widget_constructors
class PersonalInformationScreen extends StatefulWidget {
  static const routeName = '/personal-information';

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _personalInfoForm = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneCodeController.dispose();
    _phoneNumberController.dispose();
  }

  void _submitPersonalInfo() {
    final isValid = _personalInfoForm.currentState!.validate();
    if (isValid) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            'Your Information has been Updated',
            style: Theme.of(context).textTheme.button,
          )));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal information')),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _personalInfoForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name',
                      style: Theme.of(context).textTheme.labelMedium),
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
                  Text('Email', style: Theme.of(context).textTheme.labelMedium),
                  addVerticalSpace(10),
                  TextFormField(
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
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  addVerticalSpace(20),
                  Text('Phone Number',
                      style: Theme.of(context).textTheme.labelMedium),
                  addVerticalSpace(10),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                              maxLength: 3,
                              controller: _phoneCodeController,
                              decoration:
                                  const InputDecoration(counterText: ''),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number)),
                      addHorizontalSpace(5),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: _phoneNumberController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
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
                  addVerticalSpace(30),
                  buttonContainer(ElevatedButton(
                      onPressed: () => _submitPersonalInfo(),
                      child: padButtonText(text: 'SUBMIT CHANGES'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
