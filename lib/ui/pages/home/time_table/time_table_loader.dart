import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/models/app_user/app_user.dart';
import 'package:bingnuos_admin_panel/models/schedule/schedule.dart';
import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/services/hive_service.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/time_table_widget.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';

class TimeTableLoader extends StatefulWidget {
  const TimeTableLoader({Key? key}) : super(key: key);

  @override
  State<TimeTableLoader> createState() => _TimeTableLoaderState();
}

class _TimeTableLoaderState extends State<TimeTableLoader> {
  final _firestoreService = FirestoreService();
  Stream<QuerySnapshot>? _schedulesStream;
  late final ValueListenable<Box<AppUser>> _userBoxListenable;
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
        final appUser = userBox.get(USER_KEY);
        if (appUser == null) {
          return const Center(child: CircularProgressIndicator());
        }
        _schedulesStream = _firestoreService.listenSchedules(appUser);
        return StreamBuilder<QuerySnapshot>(
          stream: _schedulesStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                appUser.role != admin && appUser.moderationGroups!.isEmpty) {
              Logger.i('No data or no groups to moderate.');
              _schedules = [];
            } else {
              _schedules = snapshot.data!.docs
                  .map(
                      (e) => Schedule.fromMap(e.data() as Map<String, dynamic>))
                  .toList();
              Logger.i('Schedules received: ${_schedules.length}.');
            }
            _schedules.sort((a, b) => a.group.compareTo(b.group));
            return TimeTableWidget(
              schedules: _schedules,
            );
          },
        );
      },
    );
  }
}
