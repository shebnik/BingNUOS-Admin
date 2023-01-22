import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocale {
  final BuildContext context;
  final AppLocalizations? locale;




  AppLocale(this.context) : locale = AppLocalizations.of(context);

  String get appName => 'BingNuos';
  String get appDescription => 'BingNuos Admin Panel';
  String get language => locale?.language ?? 'Language';
  String get lightTheme => locale?.lightTheme ?? 'Light Theme';
  String get darkTheme => locale?.darkTheme ?? 'Dark Theme';
  String get autoTheme => locale?.autoTheme ?? 'Auto Theme';
  String get autorization => locale?.autorization ?? 'Autorization';
  String get login => locale?.login ?? 'Login';
  String get password => locale?.password ?? 'Password';
  String get email => locale?.email ?? 'Email';
  String get name => locale?.name ?? 'Name';
  String get forgotPassword => locale?.forgotPassword ?? 'Forgot password?';
  String get resetHere => locale?.resetHere ?? 'Reset here';
  String get emailWrong => locale?.emailWrong ?? 'Email is wrong';
  String get passwordWrong => locale?.passwordWrong ?? 'Password is wrong';
  String get ok => locale?.ok ?? 'OK';

  
  String get more => locale?.more ?? 'More';
  String get tutorial => locale?.tutorial ?? 'Tutorial';
  String get notices => locale?.notices ?? 'Notices';
  String get logout => locale?.logout ?? 'Logout';

  String get instruction => locale?.instruction ?? 'Instruction';
  String get instruction1 =>
      locale?.instruction1 ??
      'You can switch days of the week using the panel at the top.';
  String get instruction2 =>
      locale?.instruction2 ??
      'With the help of the “+” sign, you can add new groups and new subjects to the schedule.';
  String get instruction3 =>
      locale?.instruction3 ??
      'In the group addition window, you can specify a specific number for it.';
  String get instruction4 =>
      locale?.instruction4 ??
      'In the subject addition window, you can specify a specific name, room number, and teacher\'s name.';
  String get instruction5 =>
      locale?.instruction5 ??
      'When you click on the subject window, you can change the data in it.';
  String get instruction6 =>
      locale?.instruction6 ??
      'When you click on the group window, you can change its name.';
}
