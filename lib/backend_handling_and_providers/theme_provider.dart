import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  darkThemeToggle() {
    isDark ? isDark = false : isDark = true;
    notifyListeners();
  }
}
