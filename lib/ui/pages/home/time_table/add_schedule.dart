import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AddSchedule extends StatelessWidget {
  
  const AddSchedule({
    Key? key,
    required this.group,
    required this.index,
  }) : super(key: key);

  final String group;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: 200,
        height: 70,
        child: Icon(
          Icons.add,
          color: AppTheme.primaryLight,
        ),
      ),
      // onTap: () => controller.addPressed(
      //   addGroup: addGroup,
      //   group: group,
      //   number: index,
      // ),
    );
  }
}
