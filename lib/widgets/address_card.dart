import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String receiver;
  final String address;
  const AddressCard(this.receiver, this.address);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(receiver),
          Text(address),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TextButton(onPressed: null, child: Text('Edit')),
              TextButton(onPressed: null, child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }
}
