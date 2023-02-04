// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/models/schedule/schedule.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject.dart';
import 'package:bingnuos_admin_panel/providers/weekday_provider.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/subject_cell.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupsTable extends StatefulWidget {
  const GroupsTable({
    Key? key,
    required this.schedules,
    required this.dataRowHeight,
    this.cellWidth = 100,
  }) : super(key: key);

  final List<Schedule> schedules;
  final double dataRowHeight;
  final double cellWidth;

  @override
  State<GroupsTable> createState() => _GroupsTableState();
}

class _GroupsTableState extends State<GroupsTable> {
  final _horizontalScrollController = ScrollController();
  late final List<Schedule> _schedules;
  late final double dataRowHeight;
  late final double cellWidth;

  @override
  void initState() {
    _schedules = widget.schedules;
    dataRowHeight = widget.dataRowHeight;
    cellWidth = widget.cellWidth;

    _horizontalScrollController.addListener(() {
      print(_horizontalScrollController.offset);

      // if (_horizontalScrollController.offset >=
      //     _horizontalScrollController.position.maxScrollExtent) {
      //   _horizontalScrollController.jumpTo(0);
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _horizontalScrollController,
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dataRowHeight: dataRowHeight,
        border: TableBorder.symmetric(
          inside: BorderSide(
            color: Theme.of(context).splashColor,
            width: 5,
          ),
        ),
        columns: [
          ..._schedules.map((e) => DataColumn(
                label: Text(
                  e.group,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )),
        ],
        rows: List.generate(subjectTimes.length, (i) {
          return DataRow(
            cells: List.generate(_schedules.length, (j) {
              final subjects = getListBySelectedDay(_schedules[j]);
              final Subject? subject = subjects
                  ?.where(
                    (element) => element.number == i + 1,
                  )
                  .firstOrNull;
              return DataCell(
                SizedBox(
                  width: cellWidth,
                  child: subject != null ? SubjectCell(subject: subject) : null,
                ),
              );
            }),
          );
        }),
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
}
