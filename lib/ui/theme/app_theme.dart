import 'package:flutter/material.dart';

import 'package:bingnuos_admin_panel/providers/app_theme_provider.dart';

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
        canvasColor: Colors.transparent,
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
          headlineSmall: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
          displayMedium: TextStyle(
            color: Colors.black,
          ),
          labelLarge: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          labelMedium: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          labelSmall: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          titleLarge: TextStyle(
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            color: Colors.black,
          ),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: Colors.white,
          selectedColor: primaryLight,
          secondarySelectedColor: primaryLight,
          disabledColor: Colors.grey,
          secondaryLabelStyle: TextStyle(
            color: Colors.white,
          ),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          padding: EdgeInsets.all(8),
          shape: StadiumBorder(),
          elevation: 2,
          shadowColor: Colors.grey,
          selectedShadowColor: Colors.grey,
          showCheckmark: false,
          checkmarkColor: Colors.white,
        ),
      );

  static ThemeData get themeDark => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        splashColor: primaryDark,
        appBarTheme: const AppBarTheme(
          color: primaryDark,
        ),
        canvasColor: Colors.transparent,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 24,
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
          labelSmall: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: Colors.grey,
          selectedColor: primaryDark,
          secondarySelectedColor: primaryDark,
          disabledColor: Colors.grey,
          secondaryLabelStyle: TextStyle(
            color: Colors.white,
          ),
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          brightness: Brightness.dark,
          padding: EdgeInsets.all(8),
          shape: StadiumBorder(),
          elevation: 2,
          shadowColor: Colors.grey,
          selectedShadowColor: Colors.grey,
          showCheckmark: false,
          checkmarkColor: Colors.white,
        ),
      );
}
