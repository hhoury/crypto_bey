import '../providers/addresses.dart';
import '../screens/edit_address_screen.dart';
import '../utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  final int id;
  final String country;
  final String state;
  final String city;
  final String name;
  final String addressLine1;
  final String addressLine2;
  const AddressCard(Key key, this.id, this.country, this.state, this.city,
      this.name, this.addressLine1, this.addressLine2)
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
            Text(addressLine1, style: Theme.of(context).textTheme.subtitle1),
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
