import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;


  void changeTheme(ThemeMode newTheme) async {
    if (newTheme == currentTheme) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    currentTheme = newTheme;
    prefs.setString('theme', newTheme == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }


}
