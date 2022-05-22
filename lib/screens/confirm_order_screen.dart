import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:flutter/material.dart';

class ConfirmOrderScreen extends StatelessWidget {
  static const routeName = '/confirm-order';
  final String amazon = 'assets/images/amazon.png';

  @override
  Widget build(BuildContext context) {
    final order =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print(order);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(10),
            Text(
              'Order Detail',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              'Please Confirm the order',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            addVerticalSpace(20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        amazon,
                        fit: BoxFit.cover,
                        width: 55,
                        height: 55,
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(20),
                Row(
                  children: [
                    Text('Link:', style: Theme.of(context).textTheme.bodyText1),
                    addHorizontalSpace(10),
                    Text(
                      'url here',
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
                addVerticalSpace(10),
                Row(
                  children: [
                    Text('Shipping Address:',
                        style: Theme.of(context).textTheme.bodyText1),
                    addHorizontalSpace(10),
                    Text(
                      'shipping address here',
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
                addVerticalSpace(10),
                Row(
                  children: [
                    Text('Receiver:',
                        style: Theme.of(context).textTheme.bodyText1),
                    addHorizontalSpace(10),
                    Text(
                      'Receiver here',
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
                addVerticalSpace(10),
                Row(
                  children: [
                    Text('Npte:', style: Theme.of(context).textTheme.bodyText1),
                    addHorizontalSpace(10),
                    Text(
                      'Note here',
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
                addVerticalSpace(10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
