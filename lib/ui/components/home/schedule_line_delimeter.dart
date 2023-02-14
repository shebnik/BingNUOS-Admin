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
      width: width,
      height: height,
    );
  }
}
