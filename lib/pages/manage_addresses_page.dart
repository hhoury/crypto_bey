import 'package:crypto_bey/widgets/addresses_list.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ManageAddressesPage extends StatelessWidget {
  static const routeName = '/manage-addresses';

  const ManageAddressesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Addresses'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            AddressesList(),
            const Divider(
              height: 1,
            ),
            const TextButton(onPressed: null, child: Text('Add New Address'))
          ],
        ),
      ),
    );
  }
}
