import '../theme/theme_constants.dart';

import '../utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications';

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _appNotification = false;
  bool _textNotification = false;
  bool _emailNotification = false;

  Future<void> _saveNotifications(Map<String, bool> _notifications) async {
    // SAVE NOTIFICATIONS TO LOCAL STORAGE
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('appNotification') == _appNotification &&
        prefs.getBool('textNotification') == _textNotification &&
        prefs.getBool('emailNotification') == _emailNotification) {
      return;
    } else {
      prefs.setBool('appNotification', _appNotification);
      prefs.setBool('textNotification', _textNotification);
      prefs.setBool('emailNotification', _emailNotification);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: purpleColor,
          duration: const Duration(seconds: 1),
          content: Text(
            'Your Notifications settings has been saved',
            style: Theme.of(context).textTheme.button,
          )));
    }
  }

  Future<void> getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _appNotification = prefs.getBool('appNotification') ?? false;
      _textNotification = prefs.getBool('textNotification') ?? false;
      _emailNotification = prefs.getBool('emailNotification') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    // GET NOTIFICATIONS
    getNotifications();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      value: currentValue,
      onChanged: updateValue,
      title: Text(title, style: Theme.of(context).textTheme.headline4),
      subtitle: Text(description, style: Theme.of(context).textTheme.subtitle1),
      contentPadding: const EdgeInsets.all(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedNotifications = {
                  'appNotification': _appNotification,
                  'textNotification': _textNotification,
                  'emailNotification': _emailNotification,
                };
                _saveNotifications(selectedNotifications);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: ListView(
            children: [
              inputLabel(context, 'Receive Order Changes Notifications'),
              addVerticalSpace(20),
              _buildSwitchListTile(
                  'Email', 'receive notifications on email', _emailNotification,
                  (newvalue) {
                setState(() {
                  _emailNotification = newvalue;
                });
              }),
              _buildSwitchListTile(
                  'Text (SMS)',
                  'receive text messages on your phone',
                  _textNotification, (newvalue) {
                setState(() {
                  _textNotification = newvalue;
                });
              }),
              _buildSwitchListTile(
                  'App notifications',
                  'receive notifications on your app',
                  _appNotification, (newvalue) {
                setState(() {
                  _appNotification = newvalue;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
