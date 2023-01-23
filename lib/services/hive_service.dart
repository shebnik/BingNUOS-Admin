// ignore_for_file: constant_identifier_names

import 'package:bingnuos_admin_panel/models/app_user.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const USER_BOX_KEY = 'USER_BOX';
  static const LANGUAGE_BOX_KEY = 'LANGUAGE_BOX';
  static const USER_KEY = 'USER';
  static const LANGUAGE_KEY = 'LANGUAGE';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppUserAdapter());
    await Hive.openBox<AppUser>(USER_BOX_KEY);
    await Hive.openBox<String>(LANGUAGE_BOX_KEY);
  }

  static Box<AppUser> get userBox => Hive.box<AppUser>(USER_BOX_KEY);
  static Box<String> get languageBox => Hive.box<String>(LANGUAGE_BOX_KEY);

  ValueListenable<Box<AppUser>> get userBoxListenable =>
      Hive.box<AppUser>(USER_BOX_KEY).listenable();

  ValueListenable<Box<String>> get languageBoxListenable =>
      Hive.box<String>(LANGUAGE_BOX_KEY).listenable();

  Future<void> saveAppUser(AppUser appUser) async {
    await userBox.put(USER_KEY, appUser);
    Logger.d('Saved user data to hive: $appUser');
  }

  AppUser? getAppUser() {
    final appUser = userBox.get(USER_KEY);
    Logger.d('Got user data from hive: $appUser');
    return appUser;
  }

  Future<void> saveLanguage(String language) async {
    await languageBox.put(LANGUAGE_BOX_KEY, language);
    Logger.d('Saved language to hive: $language');
  }

  String getLanguage() {
    final language = languageBox.get(LANGUAGE_BOX_KEY);
    Logger.d('Got language from hive: $language');
    return language ?? 'en';
  }
}
