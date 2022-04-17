// ignore_for_file: use_key_in_widget_constructors
// #region DART PACKAGES
import '../screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
// #endregion

// #region  CONSTANTS AND UTILS
import '../theme/theme_manager.dart';
// #endregion

// #region  PROVIDERS
import '../providers/addreses.dart';
import '../providers/orders.dart';
// #endregion

// #region  ACCOUNT screenS
// #endregion

// #region  ORDERS PAGES
// #endregion

// #region AUTHENTICATION PAGES
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/reset_password_screen.dart';
import './screens/change_password_screen.dart';
import './screens/privacy_screen.dart';
import '../screens/add_address_screen.dart';
import '../screens/manage_addresses_screen.dart';
import '../screens/my_account_screen.dart';
import '../screens/new_order_confirm_screen.dart';
import '../screens/new_order_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/order_details_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/personal_information_screen.dart';
import '../screens/tabs_screen.dart';
// #endregion

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;
    return runApp(
      ChangeNotifierProvider<ThemeProvider>(
        child: MyApp(),
        create: (BuildContext context) {
          return ThemeProvider(isDarkTheme);
        },
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Addresses()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Crypto Bey',
            theme: value.getTheme(),
            initialRoute: '/',
            routes: {
              '/': ((context) => LoginScreen()),
              AddAddressScreen.routeName: (context) => AddAddressScreen(),
              ChangePasswordScreen.routeName: (context) =>
                  ChangePasswordScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              ManageAddressesScreen.routeName: (context) =>
                  ManageAddressesScreen(),
              MyAccountScreen.routeName: (context) => MyAccountScreen(),
              NewOrderConfirmationScreen.routeName: (context) =>
                  NewOrderConfirmationScreen(),
              NewOrderScreen.routeName: (context) => NewOrderScreen(),
              NotificationsScreen.routeName: (context) => NotificationsScreen(),
              OrderDetailsScreen.routeName: (context) => OrderDetailsScreen(),
              OrderHistoryScreen.routeName: (context) => OrderHistoryScreen(),
              PaymentScreen.routeName: (context) => PaymentScreen(),
              PersonalInformationScreen.routeName: (context) =>
                  PersonalInformationScreen(),
              PrivacyScreen.routeName: (context) => PrivacyScreen(),
              ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
              SignUpScreen.routeName: (context) => SignUpScreen(),
              TabsScreen.routeName: (context) => TabsScreen(),
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(builder: ((context) => LoginScreen()));
            },
          );
        },
      ),
    );
  }
}
