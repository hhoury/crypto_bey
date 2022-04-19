import 'dart:developer';

import 'package:crypto_bey/widgets/address_card.dart';

import '../models/address.dart';
import '../providers/addreses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesList extends StatelessWidget {
  final List<Address> addresses;
  AddressesList(this.addresses);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (ctx, index) =>  AddressCard(addresses[index].receiver, addresses[index].address),
    );
  }
}
