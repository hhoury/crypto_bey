import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../theme/theme_constants.dart';
import '../utils/helper_widgets.dart';

// ignore: use_key_in_widget_constructors
class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 30, 30),
        child: SingleChildScrollView(
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
              Text('Full Name', style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(),
              addVerticalSpace(20),
              Text('Phone Number',
                  style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              Row(
                children: [
                  Expanded(flex: 2, child: TextFormField()),
                  addHorizontalSpace(5),
                  Expanded(flex: 8, child: TextFormField()),
                ],
              ),
              addVerticalSpace(20),
              Text('Email', style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(),
              addVerticalSpace(20),
              Text('Password', style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(),
              addVerticalSpace(20),
              Text('Password Confirmation',
                  style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(),
              addVerticalSpace(40),
              buttonContainer(ElevatedButton(
                  onPressed: () {}, child: padButtonText('SIGNUP'))),
              addVerticalSpace(10),
              buttonContainer(ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: secondaryButtonColor),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: padButtonText('I HAVE AN ACCOUNT'))),
            ],
          ),
        ),
      ),
    );
  }
}
