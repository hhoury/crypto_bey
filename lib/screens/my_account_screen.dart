import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class MyAccountScreen extends StatelessWidget {
  static const routeName = '/my-account';

  void _toggleTheme(bool? isDark) {}

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
                TextButton(
                    onPressed: () {},
                    child: const Text('Personal information')),
              ],
            ),
            Row(
              children: [
                Icon(Icons.other_houses_outlined,
                    color: Theme.of(context).colorScheme.primary),
                TextButton(
                    onPressed: () {}, child: const Text('Manage addresses')),
              ],
            ),
            Row(
              children: [
                Icon(Icons.lock_outline,
                    color: Theme.of(context).colorScheme.primary),
                TextButton(
                    onPressed: () {},
                    child: const Text('privacy and security')),
              ],
            ),
            Row(
              children: [
                Icon(Icons.error_outline_outlined,
                    color: Theme.of(context).colorScheme.primary),
                TextButton(
                    onPressed: () {}, child: const Text('Notifications')),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone_in_talk_outlined,
                    color: Theme.of(context).colorScheme.primary),
                TextButton(onPressed: () {}, child: const Text('Contact us')),
              ],
            ),
            Row(
              children: const [
                Icon(Icons.dark_mode_outlined),
                Text('Dark Mode'),
                // Switch(value: false, onChanged: _toggleTheme(value))
              ],
            )
          ],
        ),
      ),
    );
  }
}
