import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool isDisabled;
  final double width;
  final double height;

  const AppTextButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.isDisabled = false,
    this.width = 60,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
