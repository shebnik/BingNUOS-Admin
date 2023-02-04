import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ScheduleLineDelimeter extends StatelessWidget {
  const ScheduleLineDelimeter({
    super.key,
    this.width = 5,
    this.height = 5,
  });

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).splashColor,
      // color: AppTheme.primaryLight,
      width: width,
      height: height,
    );
  }
}
