import 'package:crypto_bey/models/order.dart';
import 'package:crypto_bey/theme/theme_constants.dart';
import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_constants.dart';

class OrderDetailTop extends StatelessWidget {
  final Order order;
  final BuildContext context;
  const OrderDetailTop(this.order, this.context);

  Widget get orderImage {
    switch (order.status) {
      case OrderStatus.AWAITING_VERIFICATION:
        return SvgPicture.asset(
          'assets/images/verification.svg',
          fit: BoxFit.cover,
        );
      case OrderStatus.AWAITING_PAYMENT:
        return SvgPicture.asset(
          'assets/images/payment.svg',
          fit: BoxFit.cover,
        );
      case OrderStatus.AWAITING_ORDER:
        return SvgPicture.asset(
          'assets/images/order.svg',
          fit: BoxFit.cover,
        );
      case OrderStatus.AWAITING_DELIVERY:
        return SvgPicture.asset(
          'assets/images/moto.svg',
          fit: BoxFit.cover,
        );
      case OrderStatus.DELIVERED:
        return SvgPicture.asset(
          'assets/images/delivered.svg',
          fit: BoxFit.cover,
        );
      default:
        return SvgPicture.asset(
          'assets/images/verification.svg',
          fit: BoxFit.cover,
        );
    }
  }

  Widget get orderSummary {
    switch (order.status) {
      case OrderStatus.AWAITING_VERIFICATION:
        return inputLabel(
          context,
          'An agent will contact you for verification and for order details shortly',
        );
      case OrderStatus.AWAITING_PAYMENT:
        return inputLabel(context, 'Waiting for the payment to be done');
      case OrderStatus.AWAITING_ORDER:
        return inputLabel(context, 'Waiting for our agent to submit the order');
      // return buttonContainer(ElevatedButton(
      //     onPressed: () {}, child: const Text('View Order Screenshot')));
      case OrderStatus.AWAITING_DELIVERY:
        return Container(
          decoration: BoxDecoration(
              color: purpleColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              padButtonText(text: 'Track Package', padding: 5, custom: true),
              SelectableText(
                order.trackingNumber ?? '123-123',
                style: const TextStyle(backgroundColor: secondaryButtonColor),
              )
            ],
          ),
        );
      case OrderStatus.DELIVERED:
        return inputLabel(
            context, 'Your package has been successfully delivered');
      default:
        return inputLabel(
          context,
          'An agent will contact you for verification and for order details shortly',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVerticalSpace(20),
        orderImage,
        addVerticalSpace(10),
        orderSummary,
        addVerticalSpace(20),
      ],
    );
  }
}
