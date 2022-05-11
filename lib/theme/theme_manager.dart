import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/theme_constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme = ThemeData();
  ThemeData dark = darkTheme;
  ThemeData light = lightTheme;

  bool get darkModeOn {
    return _selectedTheme == dark;
  }

  ThemeProvider(bool darkThemeOn) {
    _selectedTheme = darkThemeOn ? dark : light;
  }

  Future<void> swapTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _selectedTheme = isDark ? dark : light;
    await prefs.setBool("darkTheme", isDark);
    notifyListeners();
  }

  void toggleTheme() async {
    _selectedTheme == dark ? _selectedTheme = light : _selectedTheme = dark;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkTheme", _selectedTheme == dark);
    notifyListeners();
  }

  ThemeData getTheme() => _selectedTheme;
}
