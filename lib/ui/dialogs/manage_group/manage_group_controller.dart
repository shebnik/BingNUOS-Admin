import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bingnuos_admin_panel/models/schedule/schedule.dart';
import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/services/hive_service.dart';
import 'package:bingnuos_admin_panel/services/snackbar_service.dart';
import 'package:bingnuos_admin_panel/ui/dialogs/are_you_sure/are_you_sure.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';

class ManageGroupController {
  final TextEditingController groupFieldController = TextEditingController();
  final ValueNotifier isGroupNumberError = ValueNotifier(false);
  final ValueNotifier isLoading = ValueNotifier(false);
  final String? group;

  ManageGroupController({
    this.group,
  }) {
    if (group != null) groupFieldController.text = group!;
  }

  late BuildContext context;
  late AppLocale appLocale;
  late bool mounted;

  Future<void> remove() async {
    isLoading.value = true;
    bool confirmation = await showConfirmationDialog() ?? false;
    if (confirmation) {
      bool success = await deleteGroup();
      showMessageAndPop(success);
    }
    isLoading.value = false;
  }

  Future<void> manage() async {
    isGroupNumberError.value = false;
    String newGroupName = groupFieldController.value.text;

    if (!Utils.validateGroup(newGroupName)) {
      isGroupNumberError.value = true;
      return;
    }
    FocusScope.of(context).unfocus();

    isLoading.value = true;
    bool success = group == null
        ? await setGroup(newGroupName)
        : await renameGroup(newGroupName);

    showMessageAndPop(success);
    isLoading.value = false;
  }

  Future<bool?> showConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AreYouSure(
        description: appLocale.removeGroupConfirmationDescription(group!),
      ),
    );
  }

  Future<bool> deleteGroup() async {
    final user = context.read<HiveService>().getAppUser();
    bool success = await FirestoreService.deleteScheduleGroup(group!);
    if (user != null && user.role == 'moderator') {
      await FirestoreService.removeUserModerationGroup(user.userId, group!);
    }
    return success;
  }

  Future<bool> setGroup(String newGroupName) async {
    final user = context.read<HiveService>().getAppUser();
    bool success = await FirestoreService.setGroupSchedule(
      Schedule(
        group: newGroupName,
      ),
    );
    if (success && user != null && user.role == 'moderator') {
      await FirestoreService.addUserModerationGroup(user.userId, newGroupName);
    }
    return success;
  }

  Future<bool> renameGroup(String newGroupName) async {
    final user = context.read<HiveService>().getAppUser();
    bool success = await FirestoreService.renameScheduleGroup(
      group: group!,
      newGroupName: newGroupName,
    );
    if (success && user != null && user.role == 'moderator') {
      await FirestoreService.removeUserModerationGroup(user.userId, group!);
      await FirestoreService.addUserModerationGroup(user.userId, newGroupName);
    }
    return success;
  }

  void showMessageAndPop(bool success) {
    String message = success ? appLocale.success : appLocale.somethingWentWrong;
    SnackBarService(context).show(message);
    if (success && mounted) {
      Navigator.pop(context);
    }
  }
}
