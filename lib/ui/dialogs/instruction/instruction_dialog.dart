import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:flutter/material.dart';

class InstructionDialog extends StatelessWidget {
  const InstructionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 2,
      backgroundColor: Colors.white,
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocale(context).instruction,
                  style: const TextStyle(
                    color: AppTheme.primaryLight,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ListTile(
                leading: const Icon(
                  Icons.circle,
                  color: AppTheme.primaryLight,
                ),
                title: Text(
                  AppLocale(context).instruction1,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.circle,
                  color: AppTheme.primaryLight,
                ),
                title: Text(
                  AppLocale(context).instruction2,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.circle,
                  color: AppTheme.primaryLight,
                ),
                title: Text(
                  AppLocale(context).instruction3,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.circle,
                  color: AppTheme.primaryLight,
                ),
                title: Text(
                  AppLocale(context).instruction4,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.circle,
                  color: AppTheme.primaryLight,
                ),
                title: Text(
                  AppLocale(context).instruction5,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.circle,
                  color: AppTheme.primaryLight,
                ),
                title: Text(
                  AppLocale(context).instruction6,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 120,
                      child: AppElevatedButton(
                        title: AppLocale(context).ok,
                        onPressed: () => Navigator.pop(context),
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
