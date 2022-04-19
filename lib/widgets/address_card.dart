import 'package:crypto_bey/utils/helper_widgets.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String receiver;
  final String address;
 AddressCard(this.receiver, this.address);
  @override
  Widget build(BuildContext context) {
    return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(receiver,style: Theme.of(context).textTheme.headline3,),
            addVerticalSpace(5),
            Text(address,style: Theme.of(context).textTheme.subtitle1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                TextButton(onPressed: (){}, child: const Text('Edit')),
                TextButton(onPressed: (){}, child: const Text('Delete',style: TextStyle(color: Color(0xFFD25353)),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
