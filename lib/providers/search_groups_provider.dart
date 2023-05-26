import 'package:flutter/material.dart';

class GroupSearchProvider with ChangeNotifier {
  String _searchValue = "";

  String get searchValue => _searchValue;

  set searchValue(String value) {
    _searchValue = value;
    notifyListeners();
  }
}

class ManageUserGroupSearchbarProvider with ChangeNotifier {
  String _searchValue = "";

  String get searchValue => _searchValue;

  set searchValue(String value) {
    _searchValue = value;
    notifyListeners();
  }
}
