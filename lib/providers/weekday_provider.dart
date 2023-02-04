import 'package:flutter/material.dart';

class WeekdayProvider with ChangeNotifier {
  int _selectedWeekday = 0;

  int get selectedWeekday => _selectedWeekday;

  set selectedWeekday(int value) {
    _selectedWeekday = value;
    notifyListeners();
  }
}
