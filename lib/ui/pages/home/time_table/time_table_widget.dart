import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/models/schedule/schedule.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject.dart';
import 'package:bingnuos_admin_panel/providers/search_groups_provider.dart';
import 'package:bingnuos_admin_panel/providers/weekday_provider.dart';
import 'package:bingnuos_admin_panel/ui/dialogs/manage_group/manage_group_dialog.dart';
import 'package:bingnuos_admin_panel/ui/dialogs/manage_subject/manage_subject_dialog.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/subject_cell.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/times_column.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';

class TimeTableWidget extends StatefulWidget {
  const TimeTableWidget({
    Key? key,
    required this.schedules,
  }) : super(key: key);

  final List<Schedule> schedules;

  @override
  State<TimeTableWidget> createState() => _TimeTableWidgetState();
}

class _TimeTableWidgetState extends State<TimeTableWidget> {
  final _horizontalScrollController = ScrollController();
  List<Schedule> _filteredSchedules = [];

  @override
  Widget build(BuildContext context) {
    String group = context.watch<GroupSearchProvider>().searchValue;
    if (group != "") {
      Logger.i('Filtering schedules by group: $group.');
      _filteredSchedules = widget.schedules
          .where((schedule) => schedule.group.contains(group))
          .toList();
    } else {
      _filteredSchedules = widget.schedules;
    }

    bool isLandscape = Utils.isLandscape(context);
    double dataRowHeight = MediaQuery.of(context).size.height / 10;
    double dataRowWidth = min(MediaQuery.of(context).size.width / 7, 200);
    double timeColumnWidth =
        isLandscape ? 130 : MediaQuery.of(context).size.width / 8;

    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimesColumn(
            dataRowHeight: dataRowHeight,
            timeColumnWidth: timeColumnWidth,
          ),
          if (_filteredSchedules.isEmpty) ...[
            Expanded(
              child: Center(
                child: Text(
                  AppLocale.of(context).noSchedules,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: RawScrollbar(
                controller: _horizontalScrollController,
                radius: const Radius.circular(16),
                crossAxisMargin: -10,
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dataRowMinHeight: dataRowHeight,
                    dataRowMaxHeight: dataRowHeight,
                    border: TableBorder.symmetric(
                      inside: BorderSide(
                        color: Theme.of(context).splashColor,
                        width: 5,
                      ),
                    ),
                    columns: [
                      ..._filteredSchedules.map((e) => DataColumn(
                            label: Expanded(
                              child: SizedBox(
                                height: dataRowHeight,
                                child: InkWell(
                                  onTap: () => showManageGroupDialog(e.group),
                                  child: Center(
                                    child: Text(
                                      e.group,
                                      style: isLandscape
                                          ? Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                          : Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                    rows: List.generate(subjectTimes.length, (i) {
                      return DataRow(
                        cells: List.generate(_filteredSchedules.length, (j) {
                          final subjects =
                              getListBySelectedDay(_filteredSchedules[j]);
                          final Subject? subject = subjects
                              ?.where(
                                (element) => element.number == i + 1,
                              )
                              .firstOrNull;
                          return DataCell(
                            SizedBox(
                              width: isLandscape ? dataRowWidth : 130,
                              child: subject != null
                                  ? SubjectCell(subject: subject)
                                  : null,
                            ),
                            onTap: () => showManageScheduleDialog(
                              _filteredSchedules[j].group,
                              subject,
                              i + 1,
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Subject>? getListBySelectedDay(Schedule schedule) {
    int weekDay = context.watch<WeekdayProvider>().selectedWeekday;
    switch (weekDay) {
      case 0:
        return schedule.monday;
      case 1:
        return schedule.tuesday;
      case 2:
        return schedule.wednesday;
      case 3:
        return schedule.thursday;
      case 4:
        return schedule.friday;
    }
    return null;
  }

  Future showManageGroupDialog(String group) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ManageGroupDialog(group: group),
    );
  }

  Future showManageScheduleDialog(
      String group, Subject? subject, int number) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ManageSubjectDialog(
        group: group,
        weekDay: Utils.weekDayFromSelectedChip(
          context.watch<WeekdayProvider>().selectedWeekday,
        ),
        subject: subject,
        number: number,
      ),
    );
  }
}
