import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class MyAccountPage extends StatelessWidget {
  static const routeName = '/my-account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('My Account'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(children: [
               Icon(Icons.person,color: Theme.of(context).colorScheme.primary),
              TextButton(onPressed: () {}, child: Text('Personal information')),
            ],),
             Row(children: [
               Icon(Icons.home,color: Theme.of(context).colorScheme.primary),
              TextButton(onPressed: () {}, child: Text('Manage addresses')),
            ],),
             Row(children: [
               Icon(Icons.lock,color: Theme.of(context).colorScheme.primary),
              TextButton(onPressed: () {}, child: Text('privacy and security')),
            ],),
             Row(children: [
               Icon(Icons.notifications,color: Theme.of(context).colorScheme.primary),
              TextButton(onPressed: () {}, child: Text('Notifications')),
            ],),
             Row(children: [
               Icon(Icons.call,color: Theme.of(context).colorScheme.primary),
              TextButton(onPressed: () {}, child: Text('Contact us')),
            ],),
          ],
        ),
      ),
    );
  }
}
