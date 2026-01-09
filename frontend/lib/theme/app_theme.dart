import 'package:flutter/material.dart';

class AppTheme {
  // 🎨 Primary seed color for the app
  static const Color seedColor = Color(0xFF5B7CFA);

  // 🌞 Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'Poppins',

    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: const Color(0xFFF7F8FC),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        height: 1.6,
      ),
    ),
  );

  // 🌙 Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'Poppins',

    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: const Color(0xFF121212),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        height: 1.6,
      ),
    ),
  );
}
