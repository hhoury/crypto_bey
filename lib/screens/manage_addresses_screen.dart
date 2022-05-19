import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/addresses.dart';
import '../widgets/addresses_list.dart';
import 'edit_address_screen.dart';

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
            children: [
              Consumer<Addresses>(
                builder: (context, addresses, _) {
                  return Expanded(
                      child: FutureBuilder(
                          future: addresses.getAddresses(),
                          builder: (ctx, snapshot) => snapshot
                                      .connectionState ==
                                  ConnectionState.waiting
                              ? const Center(child: CircularProgressIndicator())
                              : AddressesList(addressesData.addresses)));
                },
              ),
              const Divider(
                height: 1,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditAddressScreen.routeName);
                  },
                  child: const Text('Add New Address'))
            ],
          ),
        ),
      ),
    );
  }
}
