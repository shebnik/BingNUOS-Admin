import 'package:bingnuos_admin_panel/providers/app_theme_provider.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitchIconButton extends StatelessWidget {
  const ThemeSwitchIconButton({Key? key}) : super(key: key);

  static const IconData lightIcon = Icons.wb_sunny;
  static const IconData darkIcon = Icons.nightlight_round;
  static const IconData autoIcon = Icons.brightness_auto_rounded;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (context, themeProvider, _) {
        final ThemeMode currentTheme = themeProvider.selectedThemeMode;
        return IconButton(
          splashRadius: 20,
          tooltip: currentTheme == ThemeMode.light
              ? AppLocale(context).lightTheme
              : currentTheme == ThemeMode.dark
                  ? AppLocale(context).darkTheme
                  : AppLocale(context).autoTheme,
          icon: Icon(
            currentTheme == ThemeMode.light
                ? lightIcon
                : currentTheme == ThemeMode.dark
                    ? darkIcon
                    : autoIcon,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            themeProvider.toggleTheme();
          },
        );
      },
    );
  }
}
