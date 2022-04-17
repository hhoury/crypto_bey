import 'package:flutter/material.dart';

// #region COLORS
const Color darkColor = Color(0xFF1E1F26);
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
// #endregion

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
  constraints: BoxConstraints(maxHeight: 50),
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

const InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  constraints: BoxConstraints(maxHeight: 50),
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
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0),
  elevatedButtonTheme: elevatedButtonThemeData,
  inputDecorationTheme: lightInputDecorationTheme,
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
    headline2: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    headline3: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: greyTextColor,
      fontSize: 14,
    ),
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: purpleColor,
    onPrimary: Colors.white,
    secondary: Colors.indigo,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: darkColor,
    onBackground: Colors.white,
    surface: darkColor,
    onSurface: Colors.indigo,
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'OpenSans',
  elevatedButtonTheme: elevatedButtonThemeData,
  inputDecorationTheme: darkInputDecorationTheme,
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
      foregroundColor: Colors.white,
      backgroundColor: darkColor,
      elevation: 0),
  primaryColor: purpleColor,
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
    headline2: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    headline3: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 14,
    ),
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: purpleColor,
    onPrimary: Colors.white,
    secondary: purpleColor,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: darkColor,
    onBackground: Colors.white,
    surface: darkColor,
    onSurface: Colors.indigo,
  ),
);
