import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:crypto_bey/models/address.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/addresses.dart';
import '../utils/helper_widgets.dart';
import '../utils/input_helpers.dart';

// ignore: use_key_in_widget_constructors
class EditAddressScreen extends StatefulWidget {
  static const routeName = '/add-address';

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String _countryValue = '';
  // String stateValue = '';
  // String cityValue = '';
  final _editAddressForm = GlobalKey<FormState>();
  // final _addressController = TextEditingController();
  // final _unitController = TextEditingController();

  var _editedAddress =
      Address(id: '', country: '', name: '', address: '', unit: '');

  var _initValues = {'country': '', 'name': '', 'address': '', 'unit': ''};

  var _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final addressId = ModalRoute.of(context)?.settings.arguments as String?;
      if (addressId == null) {
        return;
      }
      if (addressId.isNotEmpty) {
        _editedAddress =
            Provider.of<Addresses>(context, listen: false).findById(addressId);
        _initValues = {
          'country': _editedAddress.country,
          'address': _editedAddress.address,
          'name': _editedAddress.name,
          'unit': _editedAddress.unit
        };
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    // _addressController.dispose();
    // _unitController.dispose();
  }

  void _submitAddressForm() {
    final bool countryValid = !_countryValue.toLowerCase().contains('choose') &&
        _countryValue.isNotEmpty;

    final isValid = countryValid && _editAddressForm.currentState!.validate();

    if (isValid) {
      _editAddressForm.currentState!.save();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_editedAddress.id.isNotEmpty) {
        Provider.of<Addresses>(context, listen: false)
            .editAddress(_editedAddress.id, _editedAddress);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 700),
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text(
              'Your Address has been edited',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        );
      } else {
        Provider.of<Addresses>(context, listen: false)
            .addAddress(_editedAddress);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 700),
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text(
              'Your Address has been added',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        );
      }
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 700),
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            'Please enter all address details',
            style: Theme.of(context).textTheme.button,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Address'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _editAddressForm,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  inputLabel(context, 'Name'),
                  addVerticalSpace(10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    initialValue: _initValues['name'],
                    onSaved: (value) {
                      _editedAddress = Address(
                          id: _editedAddress.id,
                          country: _editedAddress.country,
                          name: value!,
                          address: _editedAddress.address,
                          unit: _editedAddress.unit);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (_) {
                      _submitAddressForm();
                    },
                  ),
                  addVerticalSpace(20),
                  SelectState(
                    dropdownColor: Theme.of(context).colorScheme.background,
                    // style: TextStyle(color: Colors.red),
                    onCountryChanged: (value) {
                      setState(() {
                        _countryValue = removeEmoji(value).trim();
                      });
                    },
                  ),
                  addVerticalSpace(20),
                  inputLabel(context, 'Address'),
                  addVerticalSpace(10),
                  TextFormField(
                    // controller: _addressController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _editedAddress = Address(
                          id: _editedAddress.id,
                          country: _editedAddress.country,
                          name: _editedAddress.name,
                          address: value!,
                          unit: _editedAddress.unit);
                    },
                    initialValue: _initValues['address'],
                  ),
                  addVerticalSpace(20),
                  inputLabel(context, 'Unit'),
                  addVerticalSpace(10),
                  TextFormField(
                    // controller: _unitController,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your unit';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _editedAddress = Address(
                          id: _editedAddress.id,
                          country: _editedAddress.country,
                          name: _editedAddress.name,
                          address: _editedAddress.address,
                          unit: value!);
                    },
                    initialValue: _initValues['unit'],
                  ),
                  addVerticalSpace(20),
                  buttonContainer(
                    ElevatedButton(
                        onPressed: () => _submitAddressForm(),
                        child: padButtonText('Submit')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
