import 'package:crypto_bey/screens/manage_addresses_screen.dart';
import 'package:crypto_bey/screens/notifications_screen.dart';
import 'package:crypto_bey/screens/personal_information_screen.dart';
import 'package:crypto_bey/screens/privacy_screen.dart';
import 'package:crypto_bey/utils/helper_widgets.dart';
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
      body: Container(
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
                      'Personal information',
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
                      'Manage addresses',
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
                      Navigator.of(context).pushNamed(PrivacyScreen.routeName);
                    },
                    child: Text(
                      'privacy and security',
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
          ],
        ),
      ),
    );
  }
}
