import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.color = AppTheme.primaryLight,
    this.width = 140,
    this.height = 40,
    this.icon,
  }) : super(key: key);

  final String title;
  final void Function()? onPressed;

  final bool isDisabled;
  final Color color;
  final double width;
  final double height;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final text = Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white,
          ),
    );
    return SizedBox(
      width: icon != null ? width + 35 : width,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: isDisabled
              ? MaterialStateProperty.all(Colors.grey)
              : MaterialStateProperty.all(color),
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  text,
                ],
              )
            : text,
      ),
    );
  }
}
