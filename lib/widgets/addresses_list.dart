import 'package:crypto_bey/widgets/address_card.dart';

import '../models/address.dart';
import 'package:flutter/material.dart';

class AddressesList extends StatelessWidget {
  final List<Address> addresses;
  const AddressesList(this.addresses);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (ctx, index) => AddressCard(
          ValueKey(addresses[index].id),
          addresses[index].id,
          addresses[index].country,
          addresses[index].state,
          // addresses[index].city,
          addresses[index].name,
          addresses[index].address),
    );
  }
}
