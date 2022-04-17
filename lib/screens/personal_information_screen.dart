import 'package:flutter/material.dart';

import '../utils/helper_widgets.dart';

// ignore: use_key_in_widget_constructors
class PersonalInformationScreen extends StatelessWidget {
  static const routeName = '/personal-information';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal information')),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 30, 15, 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full Name', style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(),
              addVerticalSpace(20),
              Text('Email', style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              TextFormField(),
              addVerticalSpace(20),
              Text('Phone Number',
                  style: Theme.of(context).textTheme.labelMedium),
              addVerticalSpace(10),
              Row(
                children: [
                  Expanded(flex: 2, child: TextFormField()),
                  addHorizontalSpace(5),
                  Expanded(flex: 8, child: TextFormField()),
                ],
              ),
              addVerticalSpace(30),
              buttonContainer(ElevatedButton(
                  onPressed: () {}, child: padButtonText('SUBMIT CHANGES'))),
            ],
          ),
        ),
      ),
    );
  }
}
