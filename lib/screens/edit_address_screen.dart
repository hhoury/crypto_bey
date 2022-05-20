// ignore_for_file: use_build_context_synchronously

import 'package:country_state_city_picker/country_state_city_picker.dart';
import '../theme/theme_constants.dart';
import '../models/address.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/addresses.dart';
import '../utils/helper_widgets.dart';

// ignore: use_key_in_widget_constructors
class EditAddressScreen extends StatefulWidget {
  static const routeName = '/add-address';
  // Address? address;
  final String? id;
  final String? name;
  final String? country;
  final String? state;
  final String? city;
  final String? line1;
  final String? line2;
  const EditAddressScreen(
      [this.id,
      this.name,
      this.country,
      this.state,
      this.city,
      this.line1,
      this.line2]);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String _countryValue = '';
  String _stateValue = '';
  final _editAddressForm = GlobalKey<FormState>();

  var _isLoading = false;

  var _editedAddress = Address(
    id: '',
    country: '',
    state: '',
    city: '',
    name: '',
    addressLine1: '',
    addressLine2: '',
  );

  var _initValues = {
    'country': '',
    'state': '',
    'city': '',
    'name': '',
    'addressLine1': '',
    'addressLine2': ''
  };

  var _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final editedAddress =
          ModalRoute.of(context)?.settings.arguments as Address?;
      //!['id'] as String?;
      if (editedAddress == null) {
        return;
      } else {
        // _editedAddress = widget.address!;
        _initValues = {
          'country': editedAddress.country,
          'state': editedAddress.state,
          'city': editedAddress.city,
          'addressLine1': editedAddress.addressLine1,
          'addressLine2': editedAddress.addressLine2,
          'name': editedAddress.name,
        };
        _countryValue = editedAddress.country;
        _stateValue = editedAddress.state;
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _submitAddressForm() async {
    final bool countryValid = !_countryValue.toLowerCase().contains('choose') &&
        _countryValue.isNotEmpty;
    final bool stateValid = !_stateValue.toLowerCase().contains('choose') &&
        _countryValue.isNotEmpty;

    final isValid =
        countryValid && stateValid && _editAddressForm.currentState!.validate();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _editedAddress.country = _countryValue;
      _editedAddress.state = _stateValue;
      _editAddressForm.currentState!.save();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // EDIT ADDRESS
      if (_editedAddress.id.isNotEmpty) {
        await Provider.of<Addresses>(context, listen: false)
            .updateAddress(_editedAddress.id, _editedAddress);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 700),
            backgroundColor: purpleColor,
            content: Text(
              'Your Address has been edited',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        );
        Navigator.of(context).pop();
      } else {
        //ADD NEW ADDRESS
        await Provider.of<Addresses>(context, listen: false)
            .addAddress(_editedAddress);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 700),
            backgroundColor: purpleColor,
            content: Text(
              'Your Address has been added',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
    //ADDRESS IS NOT VALID
    else {
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
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
                              state: _editedAddress.state,
                              city: _editedAddress.city,
                              name: value!,
                              addressLine1: _editedAddress.addressLine1,
                              addressLine2: _editedAddress.addressLine2,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your receiver name';
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
                          dropdownColor:
                              Theme.of(context).colorScheme.background,
                          onCountryChanged: (value) {
                            setState(() {
                              _countryValue = value;
                            });
                          },
                          onStateChanged: (value) {
                            setState(() {
                              _stateValue = value;
                            });
                          },
                          selectedCountry: _countryValue,
                          selectedState: _stateValue,
                        ),
                        addVerticalSpace(20),
                        inputLabel(context, 'City'),
                        addVerticalSpace(10),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          initialValue: _initValues['city'],
                          onSaved: (value) {
                            _editedAddress = Address(
                              id: _editedAddress.id,
                              country: _editedAddress.country,
                              state: _editedAddress.state,
                              city: value!,
                              name: _editedAddress.name,
                              addressLine1: _editedAddress.addressLine1,
                              addressLine2: _editedAddress.addressLine2,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter City';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (_) {
                            _submitAddressForm();
                          },
                        ),
                        addVerticalSpace(20),
                        inputLabel(context, 'Address'),
                        addVerticalSpace(10),
                        TextFormField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
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
                              state: _editedAddress.state,
                              city: _editedAddress.city,
                              name: _editedAddress.name,
                              addressLine1: value!,
                              addressLine2: _editedAddress.addressLine2,
                            );
                          },
                          initialValue: _initValues['addressLine1'],
                        ),
                        addVerticalSpace(20),
                        inputLabel(context, 'Address Details'),
                        addVerticalSpace(10),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onSaved: (value) {
                            _editedAddress = Address(
                              id: _editedAddress.id,
                              country: _editedAddress.country,
                              state: _editedAddress.state,
                              city: _editedAddress.city,
                              name: _editedAddress.name,
                              addressLine1: _editedAddress.addressLine1,
                              addressLine2: value ?? '',
                            );
                          },
                          initialValue: _initValues['addressLine2'],
                        ),
                        addVerticalSpace(20),
                        buttonContainer(
                          ElevatedButton(
                              onPressed: () => _submitAddressForm(),
                              child: padButtonText(text: 'Submit')),
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
