// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import './pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Color darkColor = Color(0x1E1F26FF);
    const Color purpleColor = Color(0x3D68FFFF);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Bey',
      theme: ThemeData(
        primaryColor: darkColor,
        accentColor: purpleColor,
        colorScheme: ColorScheme.fromSwatch(
          primaryColorDark: darkColor,
          accentColor: purpleColor,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Crypto Bey'),
        ),
        body: LoginPage(),
      ),
    );
  }
}
