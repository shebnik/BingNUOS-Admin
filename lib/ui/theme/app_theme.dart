import 'package:bingnuos_admin_panel/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const primaryLight = Color(0xFF3E5694);
  static const primaryDark = Color(0xFF20354C);

  static Color getPrimaryAdaptive(AppThemeProvider provider) =>
      provider.currentBrightness == Brightness.light
          ? primaryLight
          : primaryDark;

  static ThemeData get themeLight => ThemeData.light().copyWith(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        splashColor: primaryLight,
        appBarTheme: const AppBarTheme(
          color: primaryLight,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: primaryLight,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            color: Colors.black,
          ),
          labelLarge: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          labelMedium: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          titleLarge: TextStyle(
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      );

  static ThemeData get themeDark => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        splashColor: primaryDark,
        appBarTheme: const AppBarTheme(
          color: primaryDark,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          labelMedium: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
          ),
        ),
      );
}
