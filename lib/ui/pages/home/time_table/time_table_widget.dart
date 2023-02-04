import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/models/app_user/app_user.dart';
import 'package:bingnuos_admin_panel/models/schedule/schedule.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject_info.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject.dart';
import 'package:bingnuos_admin_panel/providers/weekday_provider.dart';
import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/services/hive_service.dart';
import 'package:bingnuos_admin_panel/ui/components/home/schedule_line_delimeter.dart';
import 'package:bingnuos_admin_panel/ui/dialogs/manage_group/manage_group_dialog.dart';
import 'package:bingnuos_admin_panel/ui/dialogs/manage_schedule/manage_schedule_dialog.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/add_group.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/add_schedule.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/groups_table.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/subject_cell.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/time_column.dart';
import 'package:bingnuos_admin_panel/ui/theme/app_theme.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';

class TimeTableWidget extends StatefulWidget {
  const TimeTableWidget({Key? key}) : super(key: key);

  @override
  State<TimeTableWidget> createState() => _TimeTableWidgetState();
}

class _TimeTableWidgetState extends State<TimeTableWidget> {
  final _firestoreService = FirestoreService();
  late Stream<QuerySnapshot> _schedulesStream;
  late final ValueListenable<Box<AppUser>> _userBoxListenable;

  final _horizontalScrollController = ScrollController();
  List<Schedule> _schedules = [];

  @override
  void initState() {
    _userBoxListenable = context.read<HiveService>().userBoxListenable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _userBoxListenable,
      builder: (context, Box<AppUser> userBox, _) {
        final appUser = userBox.get(HiveService.USER_KEY);
        if (appUser == null) {
          return const Center(child: CircularProgressIndicator());
        }
        _schedulesStream = _firestoreService.listenSchedules(appUser);
        return StreamBuilder<QuerySnapshot>(
          stream: _schedulesStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data!.docs;
            if (data.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            _schedules = data
                .map((e) => Schedule.fromMap(e.data() as Map<String, dynamic>))
                .toList();

            double dataRowHeight = MediaQuery.of(context).size.height / 12;
            double dataRowWidth = MediaQuery.of(context).size.width / 12;

            return SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Theme.of(context).splashColor,
                          width: 5.0,
                        ),
                      ),
                    ),
                    child: DataTable(
                      dataRowHeight: dataRowHeight,
                      border: TableBorder.symmetric(
                        inside: BorderSide(
                          color: Theme.of(context).splashColor,
                          width: 5,
                        ),
                      ),
                      columns: [
                        DataColumn(
                          label: Expanded(
                            child: SizedBox(
                              height: dataRowHeight,
                              child: const AddGroup(),
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        subjectTimes.length,
                        (i) => DataRow(
                          cells: [
                            DataCell(
                              Text(
                                subjectTimes[i],
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      controller: _horizontalScrollController,
                      thumbVisibility: false,
                      child: SingleChildScrollView(
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
                                  label: Expanded(
                                    child: SizedBox(
                                      height: dataRowHeight,
                                      child: InkWell(
                                        onTap: () => {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) =>
                                                ManageGroupDialog(
                                                    group: e.group),
                                          ),
                                        },
                                        child: Center(
                                          child: Text(
                                            e.group,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                          rows: List.generate(subjectTimes.length, (i) {
                            return DataRow(
                              cells: List.generate(_schedules.length, (j) {
                                final subjects =
                                    getListBySelectedDay(_schedules[j]);
                                final Subject? subject = subjects
                                    ?.where(
                                      (element) => element.number == i + 1,
                                    )
                                    .firstOrNull;
                                return DataCell(
                                  SizedBox(
                                    width: dataRowWidth,
                                    child: subject != null
                                        ? SubjectCell(subject: subject)
                                        : null,
                                  ),
                                  onTap: () => {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) =>
                                          ManageScheduleDialog(
                                        group: _schedules[j].group,
                                        weekDay: Utils.weekDayFromSelectedChip(
                                          context
                                              .watch<WeekdayProvider>()
                                              .selectedWeekday,
                                        ),
                                        number: subject?.number ?? i + 1,
                                        subject: subject,
                                      ),
                                    ),
                                  },
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
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
