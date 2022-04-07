import 'package:crypto_bey/constants/app_constants.dart';
import 'package:flutter/material.dart';

class OrderPayment extends StatelessWidget {
  final String orderNumber;
  final double paymentAmount;
  final double waitingTime;
  final BlockChain blockchain;
  final String walletAddress;
  final String imageUrl;

  const OrderPayment(
      {required this.orderNumber,
      required this.paymentAmount,
      required this.waitingTime,
      required this.blockchain,
      required this.walletAddress,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Text('Order #$orderNumber Payment'),
          Row(
            children: [
              const Text('Payment Amount: '),
              Text('$paymentAmount USDT')
            ],
          ),
          Text('Average waiting time after transaction: $waitingTime'),
          Row(
            children: [
              Image.network(imageUrl),
              Column(
                children: const [
                  Text('ERC20'),
                  Text('TRC20'),
                  Text('OMNI'),
                ],
              ),
            ],
          ),
          const TextField(
            decoration: InputDecoration(suffixIcon: Icon(Icons.copy)),
          ), //walletaddress
          const Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: null, child: Text('CANCEL ORDER')),
          )
        ],
      ),
    );
  }
}
