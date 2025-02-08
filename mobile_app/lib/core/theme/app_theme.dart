// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color(0xFF008080),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF008080),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF008080),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          weight: 600,
        ),
      ),
    );
  }
}
