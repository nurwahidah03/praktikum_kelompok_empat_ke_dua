import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggle() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}