// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../utils/helper_widgets.dart';

class NewOrderScreen extends StatelessWidget {
  static const routeName = '/new-order';

  @override
  Widget build(BuildContext context) {
    Widget _buildStep1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputLabel(context, 'Retailer'),
          addVerticalSpace(10),
          Container(
            constraints: const BoxConstraints(minHeight: 60),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(15)),
            child: DropdownButton<String>(
                underline: DropdownButtonHideUnderline(child: Container()),
                isExpanded: true,
                dropdownColor: Theme.of(context).colorScheme.surface,
                items: ['Amnazon', 'Aliexpress', 'Ebay']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {}),
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
            constraints: const BoxConstraints(minHeight: 60),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(15)),
            child: DropdownButton<String>(
                underline: DropdownButtonHideUnderline(child: Container()),
                isExpanded: true,
                dropdownColor: Theme.of(context).colorScheme.surface,
                items: ['Address 1', 'Address 2', 'Address 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {}),
          ),
          addVerticalSpace(20),
          // Row(
          //   children: [
          //     buttonContainer(
          //         ElevatedButton(onPressed: () {}, child: const Text('Next')))
          //   ],
          // )
        ],
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
