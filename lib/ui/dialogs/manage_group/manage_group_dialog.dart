import 'package:flutter/material.dart';

import 'package:bingnuos_admin_panel/ui/components/app_text_field.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_text_button.dart';
import 'package:bingnuos_admin_panel/ui/dialogs/manage_group/manage_group_controller.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';

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
  late ManageGroupController _controller;

  @override
  void initState() {
    _controller = ManageGroupController(group: widget.group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocale appLocale = AppLocale.of(context);
    _controller.context = context;
    _controller.appLocale = appLocale;
    _controller.mounted = mounted;
    var isLandscape = Utils.isLandscape(context);
    return Dialog(
      insetPadding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 5,
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        width: isLandscape
            ? MediaQuery.of(context).size.width * 0.5
            : MediaQuery.of(context).size.width * 0.8,
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
                valueListenable: _controller.isGroupNumberError,
                builder: (context, showError, child) => AppTextField(
                  controller: _controller.groupFieldController,
                  hintText: appLocale.groupNumberHint,
                  errorText: appLocale.groupNumberWrong,
                  showError: showError,
                ),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.bottomRight,
                child: Wrap(
                  spacing: 10,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _controller.isLoading,
                      builder: (context, isDisabled, _) => AppTextButton(
                        width: 60,
                        title: appLocale.cancel,
                        isDisabled: isDisabled,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    if (_controller.group != null) ...[
                      ValueListenableBuilder(
                        valueListenable: _controller.isLoading,
                        builder: (context, value, child) => AppElevatedButton(
                          width: 100,
                          title: appLocale.remove,
                          icon: MediaQuery.of(context).size.width < 550
                              ? null
                              : Icons.delete_outline,
                          isDisabled: value,
                          onPressed: _controller.remove,
                        ),
                      ),
                    ],
                    ValueListenableBuilder(
                      valueListenable: _controller.isLoading,
                      builder: (context, isDisabled, _) => AppElevatedButton(
                        width: 100,
                        title: appLocale.done,
                        icon: MediaQuery.of(context).size.width < 550
                            ? null
                            : Icons.check_outlined,
                        isDisabled: isDisabled,
                        onPressed: _controller.manage,
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
