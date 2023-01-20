import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocale {
  final BuildContext context;
  final AppLocalizations? locale;

  AppLocale(this.context) : locale = AppLocalizations.of(context);

  String get appName => 'BingNuos';
  String get appDescription => 'BingNuos Admin Panel';
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
}
