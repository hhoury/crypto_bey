import 'package:provider/provider.dart';

import '../providers/addresses.dart';
import '../widgets/address_card.dart';

import '../models/address.dart';
import 'package:flutter/material.dart';

class AddressesList extends StatelessWidget {
  List<Address> addresses;
  AddressesList(this.addresses);
  @override
  Widget build(BuildContext context) {
    addresses = Provider.of<Addresses>(context).addresses;
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (ctx, index) => AddressCard(
        ValueKey(addresses[index].id),
        addresses[index].id,
        addresses[index].country,
        addresses[index].state,
        addresses[index].city,
        addresses[index].name,
        addresses[index].addressLine1,
        addresses[index].addressLine2,
      ),
    );
  }
}
