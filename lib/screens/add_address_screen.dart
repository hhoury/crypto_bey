import 'package:crypto_bey/utils/helper_widgets.dart';
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
        child: Form(
          child: Column(
            children: [
              const Text('Country'),
              addVerticalSpace(10),
              DropdownButton(items: const [], onChanged: null),
              addVerticalSpace(20),
              const Text('City'),
              addVerticalSpace(10),
              DropdownButton(items: const [], onChanged: null),
              addVerticalSpace(20),
              const Text('Address'),
              addVerticalSpace(10),
              const TextField(),
              addVerticalSpace(20),
              const Text('Unit'),
              addVerticalSpace(10),
              const TextField(),
              addVerticalSpace(20),
              const ElevatedButton(onPressed: null, child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
