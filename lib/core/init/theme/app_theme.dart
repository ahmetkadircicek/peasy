import 'package:flutter/material.dart';

class LightTheme {
  LightTheme._();

  static ThemeData theme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF133E87),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF757575),
      onSecondary: Color(0xFFFFFFFF),
      tertiary: Color(0xFFF7F7F7),
      onTertiary: Color(0xFF222222),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF222222),
      surfaceContainer: Color(0xFFEFEFEF),
    ),
  );
}
