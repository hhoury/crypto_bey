// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use
import 'package:flutter/material.dart';
import './pages/add_address_page.dart';
import './pages/change_password_page.dart';
import './pages/manage_addresses_page.dart';
import './pages/my_account_page.dart';
import './pages/new_order_confirm_page.dart';
import './pages/new_order_page.dart';
import './pages/notifications_page.dart';
import './pages/order_details_page.dart';
import './pages/order_history_page.dart';
import './pages/payment_page.dart';
import './pages/personal_information_page.dart';
import './pages/privacy_page.dart';
import './pages/reset_password_page.dart';
import './pages/signup_page.dart';
import './pages/tabs_page.dart';
import './pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Color darkColor = Color(0xFF1E1F26);
    const Color purpleColor = Color(0xFF3D68FF);
    const Color secondaryButtonColor = Color(0xFF696969);
    const Color redButtonColor = Color(0xFFFF6161);
    const Color waitingForPaymentColor = Color(0xFFAC2E16);
    const Color deliveringColor = Color(0xFFBDBF41);
    const Color orderedColor = Color(0xFFBDBF41);
    const Color deliveredColor = Color(0xFFC4C4C4);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Bey',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: darkColor,
        accentColor: purpleColor,
        colorScheme: ColorScheme.fromSwatch(
            primaryColorDark: darkColor,
            accentColor: purpleColor,
            backgroundColor: darkColor,
            primarySwatch: Colors.indigo),
        textTheme: ThemeData.light().textTheme.copyWith(
            titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
      initialRoute: '/',
      routes: {
        '/': ((context) => LoginPage()),
        AddAddressPage.routeName: (context) => AddAddressPage(),
        ChangePasswordPage.routeName: (context) => ChangePasswordPage(),
        LoginPage.routeName: (context) => LoginPage(),
        ManageAddressesPage.routeName: (context) => const ManageAddressesPage(),
        MyAccountPage.routeName: (context) => MyAccountPage(),
        NewOrderConfirmationPage.routeName: (context) =>
            NewOrderConfirmationPage(),
        NewOrderPage.routeName: (context) => NewOrderPage(),
        NotificationsPage.routeName: (context) => NotificationsPage(),
        OrderDetailsPage.routeName: (context) => OrderDetailsPage(),
        OrderHistoryPage.routeName: (context) => OrderHistoryPage(),
        PaymentPage.routeName: (context) => PaymentPage(),
        PersonalInformationPage.routeName: (context) =>
            PersonalInformationPage(),
        PrivacyPage.routeName: (context) => AddAddressPage(),
        ResetPasswordPage.routeName: (context) => AddAddressPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        TabsPage.routeName: (context) => AddAddressPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: ((context) => LoginPage()));
      },
    );
  }
}
