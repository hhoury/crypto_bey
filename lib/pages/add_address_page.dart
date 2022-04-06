import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AddAddressPage extends StatelessWidget {
  static const routeName = '/add-address';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Address'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [Text('data'), DropdownButton(items: [], onChanged: null)],
        ),
      ),
    );
  }
}
