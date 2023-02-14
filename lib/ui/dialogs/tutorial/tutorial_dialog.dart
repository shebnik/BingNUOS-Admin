import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';
import 'package:flutter/material.dart';

class InstructionDialog extends StatelessWidget {
  const InstructionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    bool isTrueLandscape = Utils.isLandscape(context);
    return Dialog(
      insetPadding: isTrueLandscape
          ? const EdgeInsets.symmetric(horizontal: 50)
          : const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 5,
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Center(
                child: Text(AppLocale(context).tutorial,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(height: 25),
              tutorialTile(AppLocale(context).tutorial1),
              tutorialTile(AppLocale(context).tutorial2),
              tutorialTile(AppLocale(context).tutorial3),
              tutorialTile(AppLocale(context).tutorial4),
              tutorialTile(AppLocale(context).tutorial5),
              tutorialTile(AppLocale(context).tutorial6),
              Container(
                margin: const EdgeInsets.all(24),
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

  Widget tutorialTile(String text) {
    return ListTile(
      minLeadingWidth: 8,
      leading: const Icon(
        Icons.circle,
        color: AppTheme.primaryLight,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
