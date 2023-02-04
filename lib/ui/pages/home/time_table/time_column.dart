import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/ui/components/home/schedule_line_delimeter.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/add_group.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/add_schedule.dart';
import 'package:flutter/material.dart';

final Key timeColumnKey = GlobalKey();

class TimeColumn extends StatelessWidget {
  const TimeColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: timeColumnKey,
      width: 200,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: subjectTimes.length + 2,
        separatorBuilder: (context, index) => const ScheduleLineDelimeter(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return SizedBox(
              height: 70,
              child: Center(
                child: AddGroup(),
              ),
            );
          }
          if (index < subjectTimes.length + 1) {
            return SizedBox(
              height: 70,
              child: Center(
                child: Text(
                  subjectTimes[index - 1],
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
