import 'package:bingnuos_admin_panel/providers/app_theme_provider.dart';
import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.color = AppTheme.primaryLight,
    this.width = 120,
    this.height = 40,
  }) : super(key: key);

  final String title;
  final void Function()? onPressed;

  final bool isDisabled;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: isDisabled
              ? MaterialStateProperty.all(Colors.grey)
              : MaterialStateProperty.all(color),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
