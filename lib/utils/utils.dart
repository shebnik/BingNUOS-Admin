import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';

class Utils {
  static bool isLandscape(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var width = MediaQuery.of(context).size.width;
    return width > 800 && isLandscape;
  }

  static bool emailValid(email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  static bool passwordValid(password) => RegExp(r'^.{6,}$').hasMatch(password);

  static bool validateGroup(String number) {
    if (number.isEmpty || number.contains(' ')) {
      return false;
    } else {
      return true;
    }
  }

  static String formatNumber(int number) {
    var formatter = NumberFormat('#,###');
    return formatter.format(number).replaceAll(',', ' ');
  }

  static List<TextInputFormatter> getInputFormatters({
    bool isNumberType = false,
  }) {
    return [
      LengthLimitingTextInputFormatter(64),
      FilteringTextInputFormatter.deny(
        RegExp(
            r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
      ),
      if (isNumberType)
        FilteringTextInputFormatter.allow(RegExp(r'([0-9]+[.,]?[0-9]*)')),
    ];
  }

  static Future<void> openURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static String nameFromWeekDay(AppLocale locale, WeekDay weekDay) {
    switch (weekDay) {
      case WeekDay.monday:
        return locale.monday;
      case WeekDay.tuesday:
        return locale.tuesday;
      case WeekDay.wednesday:
        return locale.wednesday;
      case WeekDay.thursday:
        return locale.thursday;
      case WeekDay.friday:
        return locale.friday;
    }
  }

  static String arrayPathFromWeekDay(WeekDay day) {
    switch (day) {
      case WeekDay.monday:
        return 'monday';
      case WeekDay.tuesday:
        return 'tuesday';
      case WeekDay.wednesday:
        return 'wednesday';
      case WeekDay.thursday:
        return 'thursday';
      case WeekDay.friday:
        return 'friday';
    }
  }

  static weekDayFromSelectedChip(int selectedWeekday) {
    switch (selectedWeekday) {
      case 0:
        return WeekDay.monday;
      case 1:
        return WeekDay.tuesday;
      case 2:
        return WeekDay.wednesday;
      case 3:
        return WeekDay.thursday;
      case 4:
        return WeekDay.friday;
    }
  }
}
