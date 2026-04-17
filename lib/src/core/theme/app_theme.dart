import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    primaryColor: const Color(0xFF007AFF),
    scaffoldBackgroundColor: const Color(0xFFF5F7FB),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF007AFF),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      centerTitle: true,
      elevation: 0,
    ),
  );
}