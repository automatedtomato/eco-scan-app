import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: const Color(0xFF008080), // Teal color
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF008080),
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF008080),
        foregroundColor: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.grey[50],
    );
  }
}
