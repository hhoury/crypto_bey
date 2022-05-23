// ignore_for_file: use_key_in_widget_constructors

import 'package:crypto_bey/screens/confirm_order_screen.dart';

import '../constants/app_constants.dart';
import '../models/address.dart';
import '../providers/addresses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/helper_widgets.dart';
import '../utils/input_helpers.dart';

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

  final _newOrderForm = GlobalKey<FormState>();
  final _orderLinkController = TextEditingController(text: '');
  final _noteController = TextEditingController(text: '');

  void _submitNewOrder() {
    final isValid = _newOrderForm.currentState!.validate();
    if (isValid) {
      Navigator.of(context).pushNamed(ConfirmOrderScreen.routeName, arguments: {
        'retailer': _selectedRetailer,
        'orderLink': _orderLinkController.text,
        'note': _noteController.text,
        'address': _selectedAddress
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _orderLinkController.dispose();
    _noteController.dispose();
  }

  _loadData() async {
    _addresses =
        await Provider.of<Addresses>(context, listen: false).getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildAddressDropDown() {
      return Consumer<Addresses>(
        builder: (context, addresses, _) {
          return FutureBuilder(
            future: addresses.getAddresses(),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : DropdownButtonFormField<Address>(
                        isDense: false,
                        borderRadius: BorderRadius.circular(15),
                        validator: (value) {
                          if (value == null) {
                            return 'Please choose your Address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          constraints: BoxConstraints(minHeight: 80),
                        ),
                        itemHeight: 65,
                        isExpanded: true,
                        value: _selectedAddress,
                        dropdownColor: Theme.of(context).colorScheme.surface,
                        items: _addresses
                            .map<DropdownMenuItem<Address>>((Address address) {
                          return DropdownMenuItem<Address>(
                            value: address,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(address.name,
                                    style: Theme.of(context).textTheme.headline3
                                    // ?.copyWith(color: purpleColor),
                                    ),
                                addVerticalSpace(15),
                                Text(
                                  address.addressLine1,
                                  style: Theme.of(context).textTheme.subtitle1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedAddress = value;
                          });
                        }),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Place a New Order'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _newOrderForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputLabel(context, 'Retailer'),
                addVerticalSpace(10),
                DropdownButtonFormField<String>(
                    alignment: Alignment.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select a Retailer';
                      }
                      return null;
                    },
                    borderRadius: BorderRadius.circular(15),
                    isExpanded: true,
                    value: _selectedRetailer,
                    dropdownColor: Theme.of(context).colorScheme.surface,
                    items: ['Amazon', 'Aliexpress', 'Ebay', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        alignment: Alignment.center,
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRetailer = value!;
                      });
                    }),
                addVerticalSpace(20),
                inputLabel(context, 'Order Link'),
                addVerticalSpace(10),
                TextFormField(
                  controller: _orderLinkController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Order Link can\'t be empty';
                    }
                    if (!validateUrl(value)) {
                      return 'Please Enter a valid url';
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
                    onPressed: () => _submitNewOrder(),
                    child: padButtonText(text: 'Next'),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
