import 'package:provider/provider.dart';

import '../screens/manage_addresses_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/personal_information_screen.dart';
import '../screens/privacy_screen.dart';
import '../theme/theme_manager.dart';
import '../utils/helper_widgets.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class MyAccountScreen extends StatelessWidget {
  static const routeName = '/my-account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('My Account'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline,
                      color: Theme.of(context).colorScheme.primary),
                  addHorizontalSpace(10),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(PersonalInformationScreen.routeName);
                      },
                      child: Text(
                        'Personal Information',
                        style: Theme.of(context).textTheme.headline2,
                      )),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.other_houses_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  addHorizontalSpace(10),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ManageAddressesScreen.routeName);
                      },
                      child: Text(
                        'Manage Addresses',
                        style: Theme.of(context).textTheme.headline2,
                      )),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.lock_outline,
                      color: Theme.of(context).colorScheme.primary),
                  addHorizontalSpace(10),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(PrivacyScreen.routeName);
                      },
                      child: Text(
                        'Privacy and Security',
                        style: Theme.of(context).textTheme.headline2,
                      )),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.error_outline_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  addHorizontalSpace(10),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(NotificationsScreen.routeName);
                      },
                      child: Text(
                        'Notifications',
                        style: Theme.of(context).textTheme.headline2,
                      )),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone_in_talk_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  addHorizontalSpace(10),
                  TextButton(
                      onPressed: () {
                        //  Navigator.of(context)
                        //     .pushNamed();
                      },
                      child: Text(
                        'Contact us',
                        style: Theme.of(context).textTheme.headline2,
                      )),
                ],
              ),
              // Row(
              //   children: [
              // Icon(Icons.dark_mode_outlined,
              //     color: Theme.of(context).colorScheme.primary),
              // addHorizontalSpace(10),
              // TextButton(
              //     onPressed: null,
              //     child: Text(
              //       'Dark Mode',
              //       style: Theme.of(context).textTheme.headline2,
              //     )),
              Row(
                children: [
                  Icon(Icons.dark_mode_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  addHorizontalSpace(20),
                  Text(
                    'Dark Theme',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Switch(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value:
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .darkModeOn,
                          onChanged: (value) {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme();
                          }),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
