
import 'package:crypto_bey/screens/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/addreses.dart';
import '../widgets/addresses_list.dart';

// ignore: use_key_in_widget_constructors
class ManageAddressesScreen extends StatelessWidget {
  static const routeName = '/manage-addresses';

  @override
  Widget build(BuildContext context) {
   
    final addressesData = Provider.of<Addresses>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Addresses'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
            child: Column(
              children:  [
                 Expanded(child: AddressesList(addressesData.addresses)),
               const Divider(
                  height: 1,
                ),
                TextButton(onPressed: () {
                  Navigator.of(context).pushNamed(AddAddressScreen.routeName);
                }, child: const Text('Add New Address'))
              ],
            ),
        ),
      ),
    );
  }
}
