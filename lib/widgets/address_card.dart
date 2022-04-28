import 'package:crypto_bey/providers/addresses.dart';
import 'package:crypto_bey/screens/edit_address_screen.dart';
import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  final String id;
  final String country;
  final String name;
  final String address;
  const AddressCard(Key key, this.id, this.country, this.name, this.address)
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headline3,
            ),
            addVerticalSpace(5),
            Text(address, style: Theme.of(context).textTheme.subtitle1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          EditAddressScreen.routeName,
                          arguments: id);
                    },
                    child: const Text('Edit')),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                  title: const Text(
                                    'Are You Sure?',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  content: const Text(
                                      'Do You Want To Remove this Address?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop(false);
                                        },
                                        child: const Text('No')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop(true);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();

                                          Provider.of<Addresses>(context,
                                                  listen: false)
                                              .deleteAddress(id);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration: const Duration(
                                                  milliseconds: 700),
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                              content: Text(
                                                'Your Address has been deleted',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text('Yes')),
                                  ]));
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Color(0xFFD25353)),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
