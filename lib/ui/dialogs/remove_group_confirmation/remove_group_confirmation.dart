import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/services/snackbar_service.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_text_button.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:flutter/material.dart';

class RemoveGroupConfirmation extends StatefulWidget {
  final String group;

  const RemoveGroupConfirmation({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  State<RemoveGroupConfirmation> createState() =>
      _RemoveGroupConfirmationState();
}

class _RemoveGroupConfirmationState extends State<RemoveGroupConfirmation> {
  String get group => widget.group;

  ValueNotifier isLoading = ValueNotifier(false);

  Future<void> remove() async {
    isLoading.value = true;
    bool result = await FirestoreService.deleteGroup(group);
    if (!mounted) return;

    if (result) {
      Navigator.pop(context);
    } else {
      SnackBarService(context).show(AppLocale.of(context).somethingWentWrong);
    }
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale(context);
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
                locale.areYouSure,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, disabled, child) => AppTextButton(
                        title: locale.cancel,
                        isDisabled: disabled,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, disabled, child) => AppElevatedButton(
                        width: 120,
                        isDisabled: disabled,
                        title: locale.remove,
                        onPressed: remove,
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
