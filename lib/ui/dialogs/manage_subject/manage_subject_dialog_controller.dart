import 'package:flutter/material.dart';

import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject_info.dart';
import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/services/snackbar_service.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';

class ManageSubjectDialogController {
  final int number;
  final String group;
  final WeekDay weekDay;
  final Subject? subject;

  ManageSubjectDialogController({
    required this.group,
    required this.weekDay,
    required this.number,
    this.subject,
  });

  // TextEditingControllers
  final nameTEC = TextEditingController();
  final teacherTEC = TextEditingController();
  final cabinetTEC = TextEditingController();

  final evenNameTEC = TextEditingController();
  final evenTeacherTEC = TextEditingController();
  final evenCabinetTEC = TextEditingController();

  final oddNameTEC = TextEditingController();
  final oddTeacherTEC = TextEditingController();
  final oddCabinetTEC = TextEditingController();

  // isTECError
  final isNameError = ValueNotifier(false);
  final isTeacherError = ValueNotifier(false);
  final isCabinetError = ValueNotifier(false);

  final isEvenNameError = ValueNotifier(false);
  final isEvenTeacherError = ValueNotifier(false);
  final isEvenCabinetError = ValueNotifier(false);

  final isOddNameError = ValueNotifier(false);
  final isOddTeacherError = ValueNotifier(false);
  final isOddCabinetError = ValueNotifier(false);

  final isLoading = ValueNotifier(false);
  final isDivided = ValueNotifier(false);

  late BuildContext _context;
  late bool _mounted;
  late AppLocale _locale;

  set context(BuildContext context) => _context = context;
  set mounted(bool mounted) => _mounted = mounted;
  set locale(AppLocale locale) => _locale = locale;

  String getTitle() {
    if (subject != null) {
      return _locale.editSubject;
    } else {
      return _locale.addSubject;
    }
  }

  String getDescription() {
    String weekday = Utils.nameFromWeekDay(_locale, weekDay);
    String description =
        '${_locale.group} $group, ${_locale.on} $weekday, ${_locale.number} $number.';
    return description;
  }

  Future<void> remove() async {
    isLoading.value = true;

    final fieldSubject = readFields();
    if (fieldSubject == null) {
      isLoading.value = false;
      return;
    }

    bool success = await FirestoreService.removeSchedule(
      group: group,
      weekDay: weekDay,
      subject: fieldSubject,
    );

    showMessageAndPop(success);
    isLoading.value = false;
  }

  Future<void> manage() async {
    isLoading.value = true;

    final fieldSubjectInfo = readFields();
    if (fieldSubjectInfo == null) {
      isLoading.value = false;
      return;
    }

    bool success = subject != null
        ? await FirestoreService.updateSchedule(
            fieldSubject: fieldSubjectInfo,
            subject: subject!,
            group: group,
            weekDay: weekDay,
          )
        : await FirestoreService.addSchedule(
            group: group,
            weekDay: weekDay,
            subject: fieldSubjectInfo,
          );

    showMessageAndPop(success);
    isLoading.value = false;
  }

  void showMessageAndPop(bool success) {
    String message;

    if (success) {
      message = _locale.success;
      if (_mounted) {
        Navigator.pop(_context);
      }
    } else {
      message = _locale.somethingWentWrong;
    }

    if (_mounted) {
      SnackBarService(_context).show(message);
    }
  }

  void updateTextControllers() {
    if (subject == null) return;

    isDivided.value = subject!.isDivided;

    nameTEC.text = subject!.subject?.name ?? '';
    teacherTEC.text = subject!.subject?.teacher ?? '';
    cabinetTEC.text = subject!.subject?.cabinet ?? '';

    evenNameTEC.text = subject!.evenSubject?.name ?? '';
    evenTeacherTEC.text = subject!.evenSubject?.teacher ?? '';
    evenCabinetTEC.text = subject!.evenSubject?.cabinet ?? '';

    oddNameTEC.text = subject!.oddSubject?.name ?? '';
    oddTeacherTEC.text = subject!.oddSubject?.teacher ?? '';
    oddCabinetTEC.text = subject!.oddSubject?.cabinet ?? '';
  }

  Subject? readFields() {
    SubjectInfo? subjectInfo, evenSubjectInfo, oddSubjectInfo;

    subjectInfo = SubjectInfo(
      name: nameTEC.value.text,
      cabinet: cabinetTEC.value.text,
      teacher: teacherTEC.value.text,
    );

    evenSubjectInfo = SubjectInfo(
      name: evenNameTEC.value.text,
      cabinet: evenCabinetTEC.value.text,
      teacher: evenTeacherTEC.value.text,
    );

    oddSubjectInfo = SubjectInfo(
      name: oddNameTEC.value.text,
      cabinet: oddCabinetTEC.value.text,
      teacher: oddTeacherTEC.value.text,
    );

    if (isDivided.value) {
      if (!validateFields(evenSubjectInfo, SubjectType.evenSubject) ||
          !validateFields(oddSubjectInfo, SubjectType.oddSubject)) {
        return null;
      }
    } else {
      if (!validateFields(subjectInfo, SubjectType.subject)) {
        return null;
      }
    }

    return Subject(
      isDivided: isDivided.value,
      number: number,
      subject: subjectInfo,
      evenSubject: evenSubjectInfo,
      oddSubject: oddSubjectInfo,
    );
  }

  bool validateFields(SubjectInfo subjectInfo, SubjectType subjectType) {
    switch (subjectType) {
      case SubjectType.subject:
        if (subjectInfo.name.length < 3) {
          isNameError.value = true;
          return false;
        } else {
          isNameError.value = false;
        }
        if (subjectInfo.cabinet.length < 3) {
          isCabinetError.value = true;
          return false;
        } else {
          isCabinetError.value = false;
        }
        if (subjectInfo.teacher.length < 3) {
          isTeacherError.value = true;
          return false;
        } else {
          isTeacherError.value = false;
        }
        return true;
      case SubjectType.evenSubject:
        if (subjectInfo.name.length < 3) {
          isEvenNameError.value = true;
          return false;
        } else {
          isEvenNameError.value = false;
        }
        if (subjectInfo.cabinet.length < 3) {
          isEvenCabinetError.value = true;
          return false;
        } else {
          isEvenCabinetError.value = false;
        }
        if (subjectInfo.teacher.length < 3) {
          isEvenTeacherError.value = true;
          return false;
        } else {
          isEvenTeacherError.value = false;
        }
        return true;
      case SubjectType.oddSubject:
        if (subjectInfo.name.length < 3) {
          isOddNameError.value = true;
          return false;
        } else {
          isOddNameError.value = false;
        }
        if (subjectInfo.cabinet.length < 3) {
          isOddCabinetError.value = true;
          return false;
        } else {
          isOddCabinetError.value = false;
        }
        if (subjectInfo.teacher.length < 3) {
          isOddTeacherError.value = true;
          return false;
        } else {
          isOddTeacherError.value = false;
        }
        return true;
    }
  }

  TextEditingController getTextController(
      SubjectType subjectType, SubjectControllerType controllerType) {
    switch (subjectType) {
      case SubjectType.subject:
        switch (controllerType) {
          case SubjectControllerType.name:
            return nameTEC;
          case SubjectControllerType.cabinet:
            return cabinetTEC;
          case SubjectControllerType.teacher:
            return teacherTEC;
        }
      case SubjectType.evenSubject:
        switch (controllerType) {
          case SubjectControllerType.name:
            return evenNameTEC;
          case SubjectControllerType.cabinet:
            return evenCabinetTEC;
          case SubjectControllerType.teacher:
            return evenTeacherTEC;
        }
      case SubjectType.oddSubject:
        switch (controllerType) {
          case SubjectControllerType.name:
            return oddNameTEC;
          case SubjectControllerType.cabinet:
            return oddCabinetTEC;
          case SubjectControllerType.teacher:
            return oddTeacherTEC;
        }
    }
  }

  ValueNotifier getValueNotifier(
      SubjectType subjectType, SubjectControllerType controllerType) {
    switch (subjectType) {
      case SubjectType.subject:
        switch (controllerType) {
          case SubjectControllerType.name:
            return isNameError;
          case SubjectControllerType.cabinet:
            return isCabinetError;
          case SubjectControllerType.teacher:
            return isTeacherError;
        }
      case SubjectType.evenSubject:
        switch (controllerType) {
          case SubjectControllerType.name:
            return isEvenNameError;
          case SubjectControllerType.cabinet:
            return isEvenCabinetError;
          case SubjectControllerType.teacher:
            return isEvenTeacherError;
        }
      case SubjectType.oddSubject:
        switch (controllerType) {
          case SubjectControllerType.name:
            return isOddNameError;
          case SubjectControllerType.cabinet:
            return isOddCabinetError;
          case SubjectControllerType.teacher:
            return isOddTeacherError;
        }
    }
  }
}
