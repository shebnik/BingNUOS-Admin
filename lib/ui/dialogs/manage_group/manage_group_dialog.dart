import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/services/snackbar_service.dart';
import 'package:bingnuos_admin_panel/ui/components/app_text_field.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_text_button.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';
import 'package:flutter/material.dart';

class ManageGroupDialog extends StatefulWidget {
  const ManageGroupDialog({
    Key? key,
    this.group,
  }) : super(key: key);

  final String? group;

  @override
  State<ManageGroupDialog> createState() => _ManageGroupDialogState();
}

class _ManageGroupDialogState extends State<ManageGroupDialog> {
  TextEditingController groupFieldController = TextEditingController();
  ValueNotifier isGroupNumberError = ValueNotifier(false);
  ValueNotifier isLoading = ValueNotifier(false);
  String? group;

  @override
  void initState() {
    group = widget.group;
    if (group != null) groupFieldController.text = group!;
    super.initState();
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
    final appLocale = AppLocale.of(context);
    bool success = await FirestoreService.manageGroup(newGroupName, group);
    String message;

    if (success) {
      message = appLocale.success;
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      message = appLocale.somethingWentWrong;
    }

    if (mounted) {
      SnackBarService(context).show(message);
    }

    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    AppLocale appLocale = AppLocale.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 5,
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        width: 400,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocale.groupNumber,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ValueListenableBuilder(
                valueListenable: isGroupNumberError,
                builder: (context, showError, child) => AppTextField(
                  controller: groupFieldController,
                  hintText: appLocale.groupNumberHint,
                  errorText: appLocale.groupNumberWrong,
                  showError: showError,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, isDisabled, _) => AppTextButton(
                        width: 80,
                        title: appLocale.cancel,
                        isDisabled: isDisabled,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, isDisabled, _) => AppElevatedButton(
                        title: appLocale.done,
                        isDisabled: isDisabled,
                        onPressed: manage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
