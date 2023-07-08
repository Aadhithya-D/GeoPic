import 'package:flutter/material.dart';

class AppTheme{

  static ThemeData darkThemeData = ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        background: Color(0xFF222831),
        primary: Color(0xFF393E46),
        secondary: Color(0xFF00ADB5),
        tertiary: Color(0xFFEEEEEE),
        error: Colors.red,
        onError: Colors.red,
        onBackground: Color(0xFF222831),
        surface: Color(0xFF393E46),
        onSurface: Color(0xFF393E46),
        onPrimary: Color(0xFF393E46),
        onSecondary: Color(0xFF00ADB5),
      ));

  static ThemeData lightThemeData = ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        background: Colors.white,
        primary: Color(0xFF00B0FF),
        secondary: Color(0xFFF4F5FA),
        tertiary: Colors.black,
        error: Colors.red,
        onError: Colors.red,
        onBackground: Color(0xFFE3FDFD),
        surface: Color(0xFF393E46),
        onSurface: Color(0xFF393E46),
        onPrimary: Color(0xFFCBF1F5),
        onSecondary: Color(0xFFA6E3E9),
      ));
}
