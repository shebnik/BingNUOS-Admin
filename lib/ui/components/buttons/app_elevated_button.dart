import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  final bool isDisabled;
  final Color color;

  const AppElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.color = AppTheme.primaryLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: isDisabled
            ? MaterialStateProperty.all(Colors.grey)
            : MaterialStateProperty.all(color),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
