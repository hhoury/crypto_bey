// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
        children: [
          ClipRRect(
            child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,width: 220,height: 200,),
          ),
          SizedBox(height: 30,),
          Align(alignment: Alignment.centerLeft, child: Text('Email')),
          TextField(),
             Align(alignment: Alignment.centerLeft, child: Text('Password')),
          TextField(),
          Align(alignment: Alignment.centerRight,child: TextButton(onPressed: (){}, child: Text('Forgot Password'))),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: (){}, child: Text('LOGIN')),
          ElevatedButton(onPressed: (){}, child: Text('SIGNUP')),
        ],
    ),
      )
    );
  }
}
 