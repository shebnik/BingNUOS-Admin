import 'package:bingnuos_admin_panel/ui/dialogs/manage_group/manage_group_dialog.dart';
import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Icon(
        Icons.add,
        color: AppTheme.primaryLight,
        size: 32,
      ),
      onTap: () => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const ManageGroupDialog(),
      ),
    );
  }
}
