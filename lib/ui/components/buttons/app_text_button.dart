import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const AppTextButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
