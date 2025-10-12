import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    // Deeper blue primary to improve contrast for white text on primary
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0D47A1), // Blue 900
      brightness: Brightness.light,
    ).copyWith(
      primary: const Color(0xFF0D47A1),
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: const Color(0xFF111827),
    );

    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0D47A1),
      brightness: Brightness.dark,
    ).copyWith(
      // Lighter primary for dark backgrounds, prefer dark text on it
      primary: const Color(0xFF82B1FF),
      onPrimary: Colors.black,
      onSurface: Colors.white,
    );

    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}


