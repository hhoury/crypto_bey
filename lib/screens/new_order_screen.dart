// ignore_for_file: use_key_in_widget_constructors

import 'package:crypto_bey/screens/edit_address_screen.dart';
import 'package:crypto_bey/theme/theme_constants.dart';

import '../constants/app_constants.dart';
import '../models/address.dart';
import '../providers/addresses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/helper_widgets.dart';

class NewOrderScreen extends StatefulWidget {
  static const routeName = '/new-order';

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final Map<Enum, String> _retailers = {
    Retailer.ALIEXPRESS: 'Aliexpress',
    Retailer.AMAZON: 'Amazon',
    Retailer.EBAY: 'Ebay',
    Retailer.OTHER: 'Other'
  };
  String _selectedRetailer = 'Amazon';
  Address? _selectedAddress;
  List<Address> _addresses = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedRetailer = 'Amazon';
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _addresses = Provider.of<Addresses>(context, listen: false).addresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildStep1() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputLabel(context, 'Retailer'),
            addVerticalSpace(10),
            Container(
              constraints: const BoxConstraints(minHeight: 60),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButton<String>(
                  underline: DropdownButtonHideUnderline(child: Container()),
                  isExpanded: true,
                  value: _selectedRetailer,
                  dropdownColor: Theme.of(context).colorScheme.surface,
                  items: ['Amazon', 'Aliexpress', 'Ebay', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRetailer = value!;
                    });
                  }),
            ),
            addVerticalSpace(20),
            inputLabel(context, 'Order Link'),
            addVerticalSpace(10),
            const TextField(),
            addVerticalSpace(20),
            inputLabel(context, 'Note'),
            addVerticalSpace(10),
            const TextField(),
            addVerticalSpace(10),
            const Divider(),
            addVerticalSpace(10),
            inputLabel(context, 'Shipping Address'),
            addVerticalSpace(10),
            Provider.of<Addresses>(context, listen: false).addresses.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(10),
                    constraints: const BoxConstraints(minHeight: 60),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton<Address>(
                        underline:
                            DropdownButtonHideUnderline(child: Container()),
                        isExpanded: true,
                        value: _selectedAddress,
                        dropdownColor: Theme.of(context).colorScheme.surface,
                        items: Provider.of<Addresses>(context, listen: false)
                            .addresses
                            .map<DropdownMenuItem<Address>>((Address address) {
                          return DropdownMenuItem<Address>(
                            value: address,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address.name,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  addVerticalSpace(3),
                                  Text(
                                    address.addressLine1,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  addVerticalSpace(6),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedAddress = value;
                          });
                        }),
                  )
                : Center(
                    child: OutlinedButton(
                      child: const Text('Add New Address'),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: greyTextColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          primary: Theme.of(context).colorScheme.primary),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(EditAddressScreen.routeName);
                      },
                    ),
                  ),
            addVerticalSpace(20),
            buttonContainer(ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed(routeName)
                },
                child: padButtonText(text: 'Next')))
          ],
        ),
      );
    }

    // Widget _buildUploadedScreenshot() {
    //   return Container(
    //     padding: const EdgeInsets.all(15),
    //     child: Column(
    //       children: const [
    //         Text('Uploaded Screenshot'),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         //    Image.network(imageUrl)
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Place a New Order'),
      ),
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(15), child: _buildStep1())),
    );
  }
}
