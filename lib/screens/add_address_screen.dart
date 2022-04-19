import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AddAddressScreen extends StatelessWidget {
  static const routeName = '/add-address';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Address'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(10),
                   Text('Country',style: Theme.of(context).textTheme.labelMedium),
                  addVerticalSpace(10),
                  
                  DropdownButtonFormField( items:  [], onChanged: null,isExpanded: true, alignment: Alignment.center,iconSize: 32),
                  addVerticalSpace(20),
                   Text('City',style: Theme.of(context).textTheme.labelMedium),
                  addVerticalSpace(10),
                  DropdownButtonFormField(items: const [], onChanged: null,isExpanded: true, alignment: Alignment.center,iconSize:32),
                  addVerticalSpace(20),
                   Text('Address',style: Theme.of(context).textTheme.labelMedium),
                  addVerticalSpace(10),
                  const TextField(textInputAction: TextInputAction.next,),
                  addVerticalSpace(20),
                   Text('Unit',style: Theme.of(context).textTheme.labelMedium),
                  addVerticalSpace(10),
                  const TextField(textInputAction: TextInputAction.done,),
                  addVerticalSpace(20),
                  buttonContainer(ElevatedButton(onPressed: () {}, child: padButtonText('Submit'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
