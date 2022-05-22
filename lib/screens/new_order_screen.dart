// ignore_for_file: use_key_in_widget_constructors

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
  var _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedRetailer = 'Amazon';
    if (_isInit) {
      _loadData();
      if (_addresses.isNotEmpty) {
        setState(() {
          _selectedAddress = _addresses[0];
        });
      }
    }

    _isInit = false;
  }

  @override
  void initState() {
    super.initState();
  }

  final _newOrderForm = GlobalKey<FormState>();
  final _orderLinkController = TextEditingController(text: '');
  final _noteController = TextEditingController(text: '');

  @override
  void dispose() {
    super.dispose();
    _orderLinkController.dispose();
    _noteController.dispose();
  }

  _loadData() async {
    _addresses = await Provider.of<Addresses>(context).getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildAddressDropDown() {
      return Consumer<Addresses>(
        builder: (context, addresses, _) {
          return FutureBuilder(
              future: addresses.getAddresses(),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(minHeight: 80),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton<Address>(
                          underline:
                              DropdownButtonHideUnderline(child: Container()),
                          isExpanded: true,
                          value: _selectedAddress,
                          dropdownColor: Theme.of(context).colorScheme.surface,
                          items: _addresses.map<DropdownMenuItem<Address>>(
                              (Address address) {
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
                                    addVerticalSpace(5),
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
                    ));
        },
      );
    }

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
            TextFormField(
              controller: _orderLinkController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Order Link can\'t be empty';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.url,
            ),
            addVerticalSpace(20),
            inputLabel(context, 'Note'),
            addVerticalSpace(10),
            TextFormField(
              controller: _noteController,
            ),
            addVerticalSpace(10),
            const Divider(),
            addVerticalSpace(10),
            inputLabel(context, 'Shipping Address'),
            addVerticalSpace(10),
            _buildAddressDropDown(),
            addVerticalSpace(20),
            buttonContainer(
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed(routeName)
                },
                child: padButtonText(text: 'Next'),
              ),
            )
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
