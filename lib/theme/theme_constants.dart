import 'package:flutter/material.dart';

// #region COLORS
const Color darkColor = Color(0xFF1E1F26);
// const Color darkColor = Color(0xFF202730);
const Color purpleColor = Color(0xFF3D68FF);
const Color secondaryButtonColor = Color(0xFF696969);
const Color redButtonColor = Color(0xFFFF6161);
const Color waitingForPaymentColor = Color(0xFFAC2E16);
const Color deliveringColor = Color(0xFFBDBF41);
const Color orderedColor = Color(0xFFBDBF41);
const Color deliveredColor = Color(0xFFC4C4C4);
const Color greyTextColor = Color(0xFF999999);
const Color darkTextFieldBackground = Color(0xFF212B37);
const Color lightTextFieldBackground = Color(0xFFEEEEEE);
const Color darkTabsBackgroundColor = Color(0xFF2B3A4D);
const Color lightTabsBackgroundColor = Colors.white;
const Color darkUnselectedTab = Color(0xFF808994);
const Color lightSelectedTab = Color(0xFF303030);
const Color lightUnSelectedTab = Color(0xFFA3A3A3);
const Color subtitleTextColor = Color(0xFF7A8087);
const Color lightSurface = Color(0xFFF0F0F0);

// #endregion

const lightAppbarTheme = AppBarTheme(
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    elevation: 0);

const lightTextTheme = TextTheme(
  headline1:
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
  headline2:
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
  headline3: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
  labelMedium: TextStyle(
    fontWeight: FontWeight.bold,
    color: greyTextColor,
    fontSize: 14,
  ),
  subtitle1: TextStyle(
    fontWeight: FontWeight.bold,
    color: subtitleTextColor,
    fontSize: 14,
  ),
  button: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
  headline4:
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
  headline6: TextStyle(color: Colors.white),
  bodyText1:
      TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
);

const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: purpleColor,
    onPrimary: Colors.white,
    secondary: Colors.indigo,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: purpleColor,
    surface: lightSurface,
    onSurface: purpleColor);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);

const InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  constraints: BoxConstraints(minHeight: 50),
  filled: true,
  fillColor: lightTextFieldBackground,
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: lightTextFieldBackground),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: purpleColor),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

const darkAppbarTheme = AppBarTheme(
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
    foregroundColor: Colors.white,
    backgroundColor: darkColor,
    elevation: 0);

const darkTextTheme = TextTheme(
  headline1:
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
  headline2:
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
  headline3: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
  labelMedium: TextStyle(
    fontWeight: FontWeight.bold,
    color: greyTextColor,
    fontSize: 14,
  ),
  subtitle1: TextStyle(
    fontWeight: FontWeight.bold,
    color: subtitleTextColor,
    fontSize: 14,
  ),
  button: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
  headline4:
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
  bodyText1:
      TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: purpleColor,
  onPrimary: Colors.white,
  secondary: purpleColor,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: darkColor,
  onBackground: Colors.white,
  surface: Color(0xFF1F2730),
  onSurface: Colors.white,
);

const InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  constraints: BoxConstraints(minHeight: 40, maxHeight: 80),
  filled: true,
  fillColor: darkTextFieldBackground,
  border: OutlineInputBorder(
    borderSide: BorderSide(color: darkTextFieldBackground),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: darkTextFieldBackground),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: purpleColor),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

ThemeData lightTheme = ThemeData(
  fontFamily: 'OpenSans',
  appBarTheme: lightAppbarTheme,
  elevatedButtonTheme: elevatedButtonThemeData,
  inputDecorationTheme: lightInputDecorationTheme,
  textTheme: lightTextTheme,
  colorScheme: lightColorScheme,
  dialogTheme: const DialogTheme(titleTextStyle: TextStyle(color: purpleColor)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 4,
      backgroundColor: Colors.white,
      unselectedItemColor: lightUnSelectedTab,
      selectedItemColor: lightSelectedTab),
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'OpenSans',
  elevatedButtonTheme: elevatedButtonThemeData,
  inputDecorationTheme: darkInputDecorationTheme,
  appBarTheme: darkAppbarTheme,
  primaryColor: purpleColor,
  textTheme: darkTextTheme,
  colorScheme: darkColorScheme,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 4,
      backgroundColor: Color(0xFF2B3A4D),
      selectedItemColor: Colors.white,
      unselectedItemColor: darkUnselectedTab),
);
