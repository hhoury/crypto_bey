import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               addVerticalSpace(20),
               Text('Receive Order Changes Notifications',style: Theme.of(context).textTheme.labelMedium),
               addVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text('Email',style: Theme.of(context).textTheme.headline4),
                   Switch(value: true, onChanged: (newValue){ },activeColor: Theme.of(context).colorScheme.primary,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text('Text (SMS)',style: Theme.of(context).textTheme.headline4),
                   Switch(value: false, onChanged: (newValue){})
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text('App Notifications',style: Theme.of(context).textTheme.headline4),
                   Switch(value: false, onChanged: (newValue){})
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
