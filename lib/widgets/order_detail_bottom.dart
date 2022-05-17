import '../models/address.dart';
import '../providers/orders.dart';
import '../theme/theme_constants.dart';
import '../utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../models/order.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class OrderDetailBottom extends StatelessWidget {
  final Order order;
  final BuildContext context;
  const OrderDetailBottom(this.order, this.context);

  String get status {
    switch (order.status) {
      case OrderStatus.CANCELLED:
        return 'Cancelled';
      case OrderStatus.AWAITING_PAYMENT:
        return 'Payment';
      case OrderStatus.AWAITING_ORDER:
        return 'Ordered';
      case OrderStatus.AWAITING_DELIVERY:
        return 'Delivering';
      case OrderStatus.DELIVERED:
        return 'Delivered';
      default:
        return 'Order';
    }
  }

  final String aliexpress = 'assets/images/aliexpress.png';
  final String amazon = 'assets/images/amazon.png';

  @override
  Widget build(BuildContext context) {
    Address orderAddress =
        Provider.of<Orders>(context).getAddressOfOrder(order.id);

    Widget _buildOrderDetails() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  status == 'Delivered' ? aliexpress : amazon,
                  fit: BoxFit.cover,
                  width: 55,
                  height: 55,
                ),
              ),
              Text(
                'Order #${order.id}',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          addVerticalSpace(10),
          Row(
            children: [
              Text('Fee:', style: Theme.of(context).textTheme.bodyText1),
              addHorizontalSpace(10),
              Text(
                order.paymentAmount.toString(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              addHorizontalSpace(10),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Text(
                      order.paid ? 'Paid' : 'Unpaid',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ))
            ],
          ),
          addVerticalSpace(10),
          Row(
            children: [
              Text('Shipping Address:',
                  style: Theme.of(context).textTheme.bodyText1),
              addHorizontalSpace(10),
              Text(
                orderAddress.addressLine1,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          addVerticalSpace(10),
          Row(
            children: [
              Text('Receiver:', style: Theme.of(context).textTheme.bodyText1),
              addHorizontalSpace(10),
              Text(
                orderAddress.name,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          addVerticalSpace(10),
          Row(
            children: [
              Text('Note:', style: Theme.of(context).textTheme.bodyText1),
              addHorizontalSpace(10),
              Flexible(
                child: Text(
                  order.note ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          addVerticalSpace(10),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
                decoration: BoxDecoration(
                    color: secondaryButtonColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Text(
                    status,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                )),
          )
        ],
      );
    }

    Widget _buildPaymentBottom() {
      final Widget qr = SvgPicture.asset('assets/images/qr.svg',
          semanticsLabel: 'qr', height: 120, width: 100, fit: BoxFit.cover);
      const String walletAddress = '0x123ashj21215j1kl23012354j1234';
      final TextEditingController walletAddressController =
          TextEditingController();
      walletAddressController.text = walletAddress;
      return Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Order #${order.id} Payment',
                style: Theme.of(context)
                    .textTheme
                    .headline2 //?.copyWith(fontSize: 16),
                ),
          ),
          addVerticalSpace(10),
          Row(
            children: [
              Text(
                'Payment Amount:',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              addHorizontalSpace(10),
              Text(
                '${order.paymentAmount} USDT',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          addVerticalSpace(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Average waiting time after transaction: 2Hrs',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 12)),
          ),
          addVerticalSpace(20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                qr,
              ],
            ),
          ),
          addVerticalSpace(20),
          TextField(
            focusNode: AlwaysDisabledFocusNode(),
            readOnly: true,
            controller: walletAddressController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: (() {
                  Clipboard.setData(
                      ClipboardData(text: walletAddressController.text));
                }),
                icon: const Icon(
                  Icons.copy,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          addVerticalSpace(20),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: const Text('CANCEL ORDER')))
        ],
      );
    }

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: order.status == OrderStatus.AWAITING_PAYMENT
            ? _buildPaymentBottom()
            : _buildOrderDetails());
  }
}
