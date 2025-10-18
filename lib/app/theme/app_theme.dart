import 'package:flutter/material.dart';

/// Theme group encapsulating a light/dark pair.
class ThemeGroup {
  final ThemeData light;
  final ThemeData dark;

  const ThemeGroup({required this.light, required this.dark});
}

/// Reusable helper for consistent widget theming across schemes.
ThemeData _buildTheme(ColorScheme scheme) {
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

class BlueAppTheme extends ThemeGroup {
  BlueAppTheme()
      : super(
          light: _buildTheme(
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF0D47A1), // Blue 900
              brightness: Brightness.light,
            ).copyWith(
              primary: const Color(0xFF0D47A1),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: const Color(0xFF111827),
            ),
          ),
          dark: _buildTheme(
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF0D47A1),
              brightness: Brightness.dark,
            ).copyWith(
              primary: const Color(0xFF82B1FF), // lighter for contrast on dark
              onPrimary: Colors.black,
              onSurface: Colors.white,
            ),
          ),
        );
}

class OrangeAppTheme extends ThemeGroup {
  OrangeAppTheme()
      : super(
          light: _buildTheme(
            ColorScheme.fromSeed(
              seedColor: const Color(0xFFFF8F00), // Orange/Amber-ish
              brightness: Brightness.light,
            ).copyWith(
              primary: const Color(0xFFF57C00), // Orange 800
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: const Color(0xFF111827),
            ),
          ),
          dark: _buildTheme(
            ColorScheme.fromSeed(
              seedColor: const Color(0xFFFF8F00),
              brightness: Brightness.dark,
            ).copyWith(
              primary: const Color(0xFFFFB74D), // Lighter orange for dark BG
              onPrimary: Colors.black,
              onSurface: Colors.white,
            ),
          ),
        );
}

class AppTheme {
  // 英文識別名稱（Dart 識別字不支援中文，避免編譯/靜態分析錯誤）
  static final ThemeGroup blue = BlueAppTheme();
  static final ThemeGroup orange = OrangeAppTheme();

  // 中文別名取用：AppTheme.zh['藍色主題']?.light / .dark
  static final Map<String, ThemeGroup> zh = {
    '藍色主題': blue,
    '橘色主題': orange,
  };

  // 向下相容：沿用既有藍色主題為預設
  static ThemeData light() => blue.light;
  static ThemeData dark() => blue.dark;
}
