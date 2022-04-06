import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SignUpPage extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Row(
          children: [
            Image.asset('logo'),
            Text('Crypto Bey')
          ],
        ),
        const SizedBox(height:20),
        Text('Full Name'),
        TextField(),
        Text('Phone Number'),
        Row(
          children: [
            TextField(),
            TextField(),
          ],
        ),
        Text('Email'),
        TextField(),
         Text('Password'),
        TextField(),
         Text('Password Confirmation'),
        TextField(),
        SizedBox(height: 30,),
        ElevatedButton(onPressed: (){}, child: Text('SIGNUP')),
        ElevatedButton(onPressed: (){}, child: Text('I HAVE AN ACCOUNT')),

      ],
    ),
    );
  }
}
