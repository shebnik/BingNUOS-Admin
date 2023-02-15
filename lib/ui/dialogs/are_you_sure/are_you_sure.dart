import 'package:flutter/material.dart';

import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_text_button.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';

class AreYouSure extends StatelessWidget {
  final String description;

  const AreYouSure({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocale(context);
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
              Center(
                child: Text(
                  appLocale.areYouSure,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 56),
              Align(
                alignment: Alignment.bottomRight,
                child: Wrap(
                  spacing: 16,
                  children: [
                    AppTextButton(
                      width: 60,
                      title: appLocale.cancel,
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    AppElevatedButton(
                      width: 100,
                      title: appLocale.yes,
                      onPressed: () => Navigator.pop(context, true),
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
