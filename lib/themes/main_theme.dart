import 'package:flutter/material.dart';

const baseColor = Color.fromARGB(255, 87, 117, 144);
ColorScheme lightColorScheme = ColorScheme.fromSeed(seedColor: baseColor);
ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: baseColor,
  brightness: Brightness.dark,
);

class MainTheme {
  static ThemeData get light {
    ThemeData theme = _getBaseTheme(lightColorScheme);
    // override ThemeData if required
    return theme;
  }

  static ThemeData get dark {
    ThemeData theme = _getBaseTheme(darkColorScheme);
    // override ThemeData if required
    return theme;
  }

  static ThemeData _getBaseTheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      appBarTheme: AppBarThemeData().copyWith(
        backgroundColor: colorScheme.primary,
        titleTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onPrimary
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          elevation: 4,
        ),
      ),
    );
  }
}
