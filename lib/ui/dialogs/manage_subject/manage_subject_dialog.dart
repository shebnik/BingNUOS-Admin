import 'package:flutter/material.dart';

import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject.dart';
import 'package:bingnuos_admin_panel/ui/components/app_text_field.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_text_button.dart';
import 'package:bingnuos_admin_panel/ui/components/home/schedule_line_delimeter.dart';
import 'package:bingnuos_admin_panel/ui/dialogs/manage_subject/manage_subject_dialog_controller.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';

class ManageSubjectDialog extends StatefulWidget {
  final int number;
  final String group;
  final WeekDay weekDay;
  final Subject? subject;

  const ManageSubjectDialog({
    Key? key,
    required this.group,
    required this.weekDay,
    required this.number,
    this.subject,
  }) : super(key: key);

  @override
  State<ManageSubjectDialog> createState() => _ManageSubjectDialogState();
}

class _ManageSubjectDialogState extends State<ManageSubjectDialog> {
  late ManageSubjectDialogController _controller;

  @override
  void initState() {
    _controller = ManageSubjectDialogController(
      group: widget.group,
      weekDay: widget.weekDay,
      number: widget.number,
      subject: widget.subject,
    );
    _controller.context = context;
    _controller.updateTextControllers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale.of(context);
    _controller.context = context;
    _controller.mounted = mounted;
    _controller.locale = locale;
    return Dialog(
      insetPadding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 5,
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  _controller.getTitle(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  _controller.getDescription(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: _controller.isDivided,
                builder: (context, value, child) {
                  return IntrinsicHeight(
                    child: Row(
                      children: [
                        if (value) ...[
                          Expanded(
                            child: subjectInfoFields(SubjectType.evenSubject),
                          ),
                          const SizedBox(width: 5),
                          const ScheduleLineDelimeter(height: double.infinity),
                          const SizedBox(width: 5),
                          Expanded(
                            child: subjectInfoFields(SubjectType.oddSubject),
                          ),
                        ] else ...[
                          Expanded(
                            child: subjectInfoFields(SubjectType.subject),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _controller.isDivided,
                    builder: (context, value, child) => Checkbox(
                      value: value,
                      onChanged: (value) {
                        _controller.isDivided.value = value!;
                      },
                    ),
                  ),
                  Text(
                    locale.isDivided,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: Wrap(
                  spacing: 16,
                  children: [
                    AppTextButton(
                      width: 90,
                      title: locale.cancel,
                      onPressed: () => Navigator.pop(context),
                    ),
                    if (widget.subject != null) ...[
                      ValueListenableBuilder(
                        valueListenable: _controller.isLoading,
                        builder: (context, value, child) => AppElevatedButton(
                          title: locale.remove,
                          width: 120,
                          isDisabled: value,
                          onPressed: _controller.remove,
                        ),
                      ),
                    ],
                    ValueListenableBuilder(
                      valueListenable: _controller.isLoading,
                      builder: (context, value, child) => AppElevatedButton(
                        title: _controller.subject != null
                            ? locale.update
                            : locale.add,
                        width: 120,
                        isDisabled: value,
                        onPressed: _controller.manage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column subjectInfoFields(SubjectType subjectType) {
    final locale = AppLocale.of(context);
    return Column(
      children: [
        if (subjectType == SubjectType.evenSubject) ...[
          Center(
            child: Text(
              locale.evenWeek,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 8),
        ] else if (subjectType == SubjectType.oddSubject) ...[
          Center(
            child: Text(
              locale.oddWeek,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 8),
        ],
        ValueListenableBuilder(
          valueListenable: _controller.getValueNotifier(
            subjectType,
            SubjectControllerType.name,
          ),
          builder: (context, value, child) => AppTextField(
            controller: _controller.getTextController(
              subjectType,
              SubjectControllerType.name,
            ),
            hintText: locale.subjectHint,
            errorText: locale.subjectNameWrong,
            showError: value,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _controller.getValueNotifier(
            subjectType,
            SubjectControllerType.cabinet,
          ),
          builder: (context, value, child) => AppTextField(
            controller: _controller.getTextController(
              subjectType,
              SubjectControllerType.cabinet,
            ),
            hintText: locale.cabinetNumberHint,
            errorText: locale.cabinetNumberWrong,
            showError: value,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _controller.getValueNotifier(
            subjectType,
            SubjectControllerType.teacher,
          ),
          builder: (context, value, child) => AppTextField(
            controller: _controller.getTextController(
              subjectType,
              SubjectControllerType.teacher,
            ),
            hintText: locale.teacherNameHint,
            errorText: locale.teacherNameWrong,
            showError: value,
          ),
        ),
      ],
    );
  }
}
