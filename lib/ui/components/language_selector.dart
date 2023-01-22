import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      iconSize: 24,
      splashRadius: 20,
      onSelected: _popupMenuSelected,
      tooltip: AppLocale(context).language,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'uk',
            child: Text(
              'Українська',
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
          PopupMenuItem(
            value: 'ru',
            child: Text(
              'Русский',
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
          PopupMenuItem(
            value: 'en',
            child: Text(
              'English',
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
        ];
      },
    );
  }

  void _popupMenuSelected(String value) {
    switch (value) {
      case 'en':
        // English
        break;
      case 'uk':
        // Українська
        break;
      case 'ru':
        // Русский
        break;
    }
  }
}
