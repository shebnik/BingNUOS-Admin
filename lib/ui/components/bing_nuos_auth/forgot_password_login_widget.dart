import 'package:flutter/material.dart';

import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';

class ForgotPasswordLoginWidget extends StatelessWidget {
  const ForgotPasswordLoginWidget({
    Key? key,
    required this.text,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);

  final String text;
  final String buttonText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 26),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
            children: [
              TextSpan(
                text: text,
              ),
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(left: 4),
                ),
              ),
              WidgetSpan(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Text(
                      buttonText,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryLight,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
