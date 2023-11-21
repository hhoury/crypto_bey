import 'package:crypto_bey/models/address.dart';
import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../providers/orders.dart';

class ConfirmOrderScreen extends StatelessWidget {
  static const routeName = '/confirm-order';
  final String amazon = 'assets/images/amazon.png';

  @override
  Widget build(BuildContext context) {
    void _submitNewOrder() async {
      //await  Provider.of<Orders>(context,listen: false).addOrder()
    }
    final order =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final shippingAddress = order['address'] as Address;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              addVerticalSpace(50),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
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
                        Text('Link:',
                            style: Theme.of(context).textTheme.bodyText1),
                        addHorizontalSpace(10),
                        Text(
                          order['orderLink'],
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
                          shippingAddress.addressLine1,
                          style: Theme.of(context).textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
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
                          shippingAddress.name,
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      ],
                    ),
                    addVerticalSpace(10),
                    Row(
                      children: [
                        Text('Note:',
                            style: Theme.of(context).textTheme.bodyText1),
                        addHorizontalSpace(10),
                        Text(
                          order['note'],
                          style: Theme.of(context).textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              addVerticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  addHorizontalSpace(20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: padButtonText(text: 'Previous'),
                    ),
                  ),
                  addHorizontalSpace(20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _submitNewOrder(),
                      child: padButtonText(text: 'Next'),
                    ),
                  ),
                  addHorizontalSpace(20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
