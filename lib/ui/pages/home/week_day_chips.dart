import 'package:bingnuos_admin_panel/providers/weekday_provider.dart';
import 'package:bingnuos_admin_panel/ui/components/home/app_choice_chip.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeekDayChips extends StatelessWidget {
  const WeekDayChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale(context);
    final weekdays = {
      0: locale.monday,
      1: locale.tuesday,
      2: locale.wednesday,
      3: locale.thursday,
      4: locale.friday
    };
    final shortWeekdays = {
      0: locale.mondayShort,
      1: locale.tuesdayShort,
      2: locale.wednesdayShort,
      3: locale.thursdayShort,
      4: locale.fridayShort
    };

    final screenWidth = MediaQuery.of(context).size.width;
    final weekdaysToUse = screenWidth < 700 ? shortWeekdays : weekdays;
    final chipWidth = screenWidth < 700 ? screenWidth / 7 : 100;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: weekdaysToUse.entries.map((entry) {
            final weekdayProvider = context.watch<WeekdayProvider>();
            int selectedWeekday = weekdayProvider.selectedWeekday;
            return Flexible(
              child: AppChoiceChip(
                width: chipWidth,
                index: entry.key,
                label: entry.value,
                isSelected: selectedWeekday == entry.key,
                onSelected: (bool selected) {
                  if (selected) {
                    Logger.i('Selected weekday: ${weekdays[entry.key]}');
                    weekdayProvider.selectedWeekday = entry.key;
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
