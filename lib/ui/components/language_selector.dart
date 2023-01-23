import 'package:bingnuos_admin_panel/services/hive_service.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      iconSize: 24,
      splashRadius: 20,
      onSelected: (value) => context.read<HiveService>().saveLanguage(value),
      tooltip: AppLocale(context).language,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'uk',
            child: Text(
              'Українська',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          PopupMenuItem(
            value: 'ru',
            child: Text(
              'Русский',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          PopupMenuItem(
            value: 'en',
            child: Text(
              'English',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ];
      },
    );
  }
}
