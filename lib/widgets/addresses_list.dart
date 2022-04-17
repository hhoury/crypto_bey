import '../providers/addreses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addressesData = Provider.of<Addresses>(context);
    final addresses = addressesData.addresses;
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (ctx, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(addresses[index].receiver),
              Text(addresses[index].address),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  TextButton(onPressed: null, child: Text('EDIT')),
                  TextButton(onPressed: null, child: Text('DELETE')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
