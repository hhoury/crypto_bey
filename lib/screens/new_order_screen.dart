// ignore_for_file: use_key_in_widget_constructors

import '../screens/edit_address_screen.dart';
import '../theme/theme_constants.dart';

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
  // final List<Address> _addresses = [];
  final _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedRetailer = 'Amazon';
    // if (_isInit) {
    //   _addresses = Provider.of<Addresses>(context).addresses;
    // }
    // if (_addresses.isNotEmpty) _selectedAddress = _addresses[0];
    // _isInit = false;
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    loadData();
    setState(() {
      // _addresses = Provider.of<Addresses>(context, listen: false).addresses;
    });
  }

  var _isLoading = false;
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    // _addresses = Provider.of<Addresses>(context, listen: false).addresses;

    setState(() {
      _isLoading = false;
    });
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

  loadData() async {
    await Provider.of<Addresses>(context, listen: false).getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final addressesData = Provider.of<Addresses>(context, listen: false);

    final _addresses = addressesData.addresses;
    if (_addresses.isNotEmpty) {
      setState(() {
        _selectedAddress = _addresses[0];
      });
    }
    Widget _buildAddressDropDown() {
      return _addresses.isNotEmpty
          ? Container(
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
                  items: _addresses
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
                              address.addressLine1,
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
                  Navigator.of(context).pushNamed(EditAddressScreen.routeName);
                },
              ),
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
