import 'package:flutter/material.dart';

class AppTheme {
  static const _primary = Color(0xFF0A74FF);

  static ThemeData lightTheme(TextTheme textTheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primary,
        brightness: Brightness.light,
      ),
      textTheme: textTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData darkTheme(TextTheme textTheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primary,
        brightness: Brightness.dark,
      ),
      textTheme: textTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
