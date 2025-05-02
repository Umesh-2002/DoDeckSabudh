// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeProvider() {
    _loadTheme();
  }

  void setDarkMode(bool value) {
    _isDark = value;
    _saveTheme();
    notifyListeners();
  }

  void toggleTheme() {
    setDarkMode(!_isDark);
  }

  Future<void> _loadTheme() async {
    final p = await SharedPreferences.getInstance();
    _isDark = p.getBool('isDark') ?? false;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('isDark', _isDark);
  }
}

