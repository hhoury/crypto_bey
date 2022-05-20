// ignore_for_file: use_build_context_synchronously

import '../models/http_exception.dart';
import '../providers/auth.dart';
import '../theme/theme_constants.dart';
import 'package:dio/dio.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/helper_widgets.dart';

// ignore: use_key_in_widget_constructors
class PersonalInformationScreen extends StatefulWidget {
  static const routeName = '/personal-information';

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final Widget _body = const Center(
    child: CircularProgressIndicator(),
  ); // Default Body
  var _isLoading = false;
  final _personalInfoForm = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(text: '');
  final _lastNameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _phoneCodeController = TextEditingController(text: '');
  final _phoneNumberController = TextEditingController(text: '');

  dynamic _prof;
  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneCodeController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  final Widget _loader = const Center(
    child: CircularProgressIndicator(),
  );

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    _prof = await Provider.of<Auth>(context, listen: false).getUserProfile();
    setState(() {
      _phoneNumberController.text = _prof['phone_number'].toString();
      _phoneCodeController.text = _prof['country_code'].toString();
      _firstNameController.text = _prof['given_name'] ?? '';
      _lastNameController.text = _prof['family_name'] ?? '';
      _emailController.text = _prof['email'] ?? '';
    });
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _submitPersonalInfo() async {
    final isValid = _personalInfoForm.currentState!.validate();
    if (isValid) {
      try {
        setState(() {
          _isLoading = true;
        });
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        await Provider.of<Auth>(context, listen: false).updateUserProfile(
            _firstNameController.text,
            _lastNameController.text,
            _phoneCodeController.text,
            _phoneNumberController.text);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: purpleColor,
            content: Text(
              'Your Information has been Updated',
              style: Theme.of(context).textTheme.button,
            )));
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      } on DioError catch (error) {
        throw HttpException(
            error.response?.data['detail']['error_description']);
      } catch (error) {
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal information')),
      body: SafeArea(
          child: _isLoading ? _loader : _buildPersonalInfoForm(context)),
    );
  }

  Widget _buildPersonalInfoForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: _personalInfoForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('First Name',
                  style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(
                // initialValue: _initValues['given_name'],
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
              Text('Last Name', style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(
                // initialValue: _initValues['family_name'],
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
              Text('Email', style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(
                // initialValue: _initValues['email'],
                readOnly: true,
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
                          // initialValue: '',
                          maxLength: 3,
                          controller: _phoneCodeController,
                          decoration: const InputDecoration(counterText: ''),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Phone Number';
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
    );
  }
}
