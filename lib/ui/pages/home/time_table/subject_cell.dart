import 'package:bingnuos_admin_panel/models/schedule/subject.dart';
import 'package:bingnuos_admin_panel/ui/components/home/schedule_line_delimeter.dart';
import 'package:flutter/material.dart';

class SubjectCell extends StatelessWidget {
  const SubjectCell({
    Key? key,
    required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    if (subject.isDivided) {
      final evenSubjectName = subject.evenSubject?.name ?? '';
      final oddSubjectName = subject.oddSubject?.name ?? '';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              evenSubjectName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const ScheduleLineDelimeter(width: double.infinity),
          Flexible(
            child: Text(
              oddSubjectName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            subject.subject?.name ?? '',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            subject.subject?.cabinet ?? '',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            subject.subject?.teacher ?? '',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
