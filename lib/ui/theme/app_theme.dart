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
          bodyText1: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryLight,
          ),
          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
          headline3: TextStyle(
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
          ),
          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
}
