import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AddAddressScreen extends StatelessWidget {
  static const routeName = '/add-address';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Address'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text('Country'),
            DropdownButton(items: const [], onChanged: null),
            const Text('City'),
            DropdownButton(items: const [], onChanged: null),
            const Text('Address'),
            const TextField(),
            const Text('Unit'),
            const TextField(),
            const ElevatedButton(onPressed: null, child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
