import 'package:bingnuos_admin_panel/models/app_user/app_user.dart';
import 'package:bingnuos_admin_panel/services/firebase/auth_service.dart';
import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/services/firebase/functions_service.dart';
import 'package:bingnuos_admin_panel/services/firebase/realtime_database.dart';
import 'package:bingnuos_admin_panel/services/snackbar_service.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/logger.dart';
import 'manage_user.dart';

class ManageUserController {
  final ManageUserType type;
  late final ValueNotifier<AppUser> user;

  // TextEditingControllers
  final nameTEC = TextEditingController();
  final emailTEC = TextEditingController();

  // ValueNotifiers
  final isLoading = ValueNotifier(false);
  final isNameError = ValueNotifier(false);
  final isEmailError = ValueNotifier(false);

  ValueNotifier<List<String>> allItems = ValueNotifier([]);
  ValueNotifier<List<String>> filteredItems = ValueNotifier([]);

  ManageUserController({
    required this.type,
    AppUser? user,
  }) {
    this.user = ValueNotifier(user ?? AppUser.empty());
    allItems = ValueNotifier([]);
    filteredItems = ValueNotifier([]);
  }

  Future<void> getGroups() async {
    allItems.value = await RealtimeDatabase.getAllGroups();
    filteredItems.value = allItems.value;
  }

  void dispose() {
    nameTEC.dispose();
    emailTEC.dispose();
    allItems.dispose();
    filteredItems.dispose();
  }

  void updateItems(String group) {
    filteredItems.value =
        allItems.value.where((element) => element.contains(group)).toList()
          ..sort((a, b) {
            final userModerationGroups = user.value.moderationGroups ?? [];
            final aContainsGroup = userModerationGroups.contains(a);
            final bContainsGroup = userModerationGroups.contains(b);

            if (aContainsGroup && !bContainsGroup) {
              return -1;
            } else if (!aContainsGroup && bContainsGroup) {
              return 1;
            } else {
              return 0;
            }
          });
  }

  Future<bool?> createAccount(BuildContext context, mounted) async {
    isNameError.value = false;
    isEmailError.value = false;
    isLoading.value = true;

    String name = nameTEC.value.text;
    String email = emailTEC.value.text.trim().toLowerCase();

    if (_validate(name, email)) {
      Map<bool, String> result = await FunctionsService().registerUser(
        name,
        email,
        user.value.moderationGroups ?? [],
      );
      bool success = result.keys.first;
      String e = result.values.first;
      Logger.i("[createAccount] success: $success, error: $e");
      if (!success && mounted) {
        SnackBarService(context).show(
          context.read<AuthService>().getFirebaseAuthErrorMessage(e, context),
        );
      }
    }
    isLoading.value = false;
    return null;
  }

  bool _validate(String name, String email) {
    if (!Utils.nameValid(name)) {
      isNameError.value = true;
      return false;
    }

    if (!Utils.emailValid(email)) {
      isEmailError.value = true;
      return false;
    }

    return true;
  }

  Future<bool> updateAccount() async {
    String name = nameTEC.value.text;
    if (!Utils.nameValid(name)) {
      isNameError.value = true;
      return false;
    }
    user.value = user.value.copyWith(name: name);
    return await FirestoreService.updateUser(user.value);
  }
}