import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  final bool? isDisabled;
  final Color color;

  const AppElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isDisabled,
    this.color = AppTheme.primaryLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ?? false ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
