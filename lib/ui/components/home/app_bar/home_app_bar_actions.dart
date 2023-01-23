import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/services/firebase/auth_service.dart';
import 'package:bingnuos_admin_panel/ui/dialogs/tutorial/tutorial_dialog.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAppBarActions extends StatefulWidget {
  const HomeAppBarActions({Key? key}) : super(key: key);

  @override
  State<HomeAppBarActions> createState() => _HomeAppBarActionsState();
}

class _HomeAppBarActionsState extends State<HomeAppBarActions> {
  Future<void> _popupMenuSelected(value) async {
    switch (value) {
      case 0:
        // Tutorial
        await showDialog(
          context: context,
          builder: (context) => const InstructionDialog(),
        );
        break;
      case 1:
        // Notices
        await Utils.openURL(notesURL);
        break;
      case 2:
        // Log out
        await context.read<AuthService>().signOut();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: AppLocale(context).more,
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: _popupMenuSelected,
      iconSize: 24,
      splashRadius: 20,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: Text(
              AppLocale(context).tutorial,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: Text(
              AppLocale(context).notices,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              AppLocale(context).logout,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ];
      },
    );
  }
}
