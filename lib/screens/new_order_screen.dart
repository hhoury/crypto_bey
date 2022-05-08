// ignore_for_file: use_key_in_widget_constructors

import 'package:crypto_bey/constants/app_constants.dart';
import 'package:crypto_bey/models/address.dart';
import 'package:crypto_bey/providers/addresses.dart';
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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _selectedRetailer = 'Amazon';
  }

  @override
  Widget build(BuildContext context) {
    var addresses = Provider.of<Addresses>(context, listen: false).addresses;

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
            Container(
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(minHeight: 60),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButton<Address>(
                  underline: DropdownButtonHideUnderline(child: Container()),
                  isExpanded: true,
                  value: _selectedAddress,
                  dropdownColor: Theme.of(context).colorScheme.surface,
                  items: addresses
                      .map<DropdownMenuItem<Address>>((Address address) {
                    return DropdownMenuItem<Address>(
                      value: address,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address.name,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            addVerticalSpace(3),
                            Text(
                              address.address,
                              style: Theme.of(context).textTheme.subtitle1,
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

    Widget _buildUploadedScreenshot() {
      return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            Text('Uploaded Screenshot'),
            SizedBox(
              height: 10,
            ),
            //    Image.network(imageUrl)
          ],
        ),
      );
    }

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
