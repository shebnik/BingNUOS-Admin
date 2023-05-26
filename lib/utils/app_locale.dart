import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocale {
  final BuildContext context;
  final AppLocalizations? locale;

  AppLocale(this.context) : locale = AppLocalizations.of(context);

  static AppLocale of(BuildContext context) {
    return AppLocale(context);
  }

  String get appName => 'BingNuos';
  String get appDescription => 'BingNuos Admin Panel';

  // Base
  String get language => locale?.language ?? 'Language';
  String get ok => locale?.ok ?? 'OK';
  String get yes => locale?.yes ?? 'Yes';
  String get no => locale?.no ?? 'No';
  String get add => locale?.add ?? 'Add';
  String get update => locale?.update ?? 'Update';
  String get more => locale?.more ?? 'More';
  String get group => locale?.group ?? 'Group';
  String get on => locale?.on ?? 'on';
  String get number => locale?.number ?? 'number';
  String get pageNotFound => locale?.pageNotFound ?? 'Page not found';
  String get done => locale?.done ?? 'Done';
  String get cancel => locale?.cancel ?? 'Cancel';
  String get error => locale?.error ?? 'Error';
  String get somethingWentWrong =>
      locale?.somethingWentWrong ?? 'Something went wrong. Try again later.';
  String get success => locale?.success ?? 'Success';
  String get areYouSure => locale?.areYouSure ?? 'Are you sure?';
  String get remove => locale?.remove ?? 'Remove';

  // Auth
  String get autorization => locale?.autorization ?? 'Autorization';
  String get login => locale?.login ?? 'Login';
  String get password => locale?.password ?? 'Password';
  String get email => locale?.email ?? 'Email';
  String get name => locale?.name ?? 'Name';
  String get forgotPassword => locale?.forgotPassword ?? 'Forgot password?';
  String get resetHere => locale?.resetHere ?? 'Reset here';
  String get rememberPassword =>
      locale?.rememeberPassword ?? 'Remember your password?';
  String get loginHere => locale?.loginHere ?? 'Login here';
  String get resetPasswordEmailSent =>
      locale?.resetPasswordEmailSent ??
      'A password reset link has been sent to your email.';

  String get emailWrong => locale?.emailWrong ?? 'Email is wrong';
  String get passwordWrong => locale?.passwordWrong ?? 'Password is wrong';
  String get resetPassword => locale?.resetPassword ?? 'Reset Password';

  // AppBar
  String get searchGroups => locale?.searchGroups ?? 'Search groups';

  // Theme
  String get lightTheme => locale?.lightTheme ?? 'Light Theme';
  String get darkTheme => locale?.darkTheme ?? 'Dark Theme';
  String get autoTheme => locale?.autoTheme ?? 'Auto Theme';

  // Menu
  String get tutorial => locale?.tutorial ?? 'Tutorial';
  String get notices => locale?.notices ?? 'Notices';
  String get manageUsers => locale?.manageUsers ?? 'Manage Users';
  String get logout => locale?.logout ?? 'Logout';

  // Home
  String get monday => locale?.monday ?? 'Monday';
  String get tuesday => locale?.tuesday ?? 'Tuesday';
  String get wednesday => locale?.wednesday ?? 'Wednesday';
  String get thursday => locale?.thursday ?? 'Thursday';
  String get friday => locale?.friday ?? 'Friday';

  String get mondayShort => locale?.mondayShort ?? 'Mon';
  String get tuesdayShort => locale?.tuesdayShort ?? 'Tue';
  String get wednesdayShort => locale?.wednesdayShort ?? 'Wed';
  String get thursdayShort => locale?.thursdayShort ?? 'Thu';
  String get fridayShort => locale?.fridayShort ?? 'Fri';

  String get noSchedules => locale?.noSchedules ?? 'No schedules';

  // Tutorial
  String get tutorialAdmin =>
      locale?.tutorialAdmin ??
      'You can add a moderator by specifying their name and email and setting up the groups available to them. The moderator can enter the panel by resetting his or her email password.';
  String get tutorial1 =>
      locale?.tutorial1 ??
      'You can switch days of the week using the panel at the top.';
  String get tutorial2 =>
      locale?.tutorial2 ??
      'With the help of the “+” sign, you can add new groups and new subjects to the schedule.';
  String get tutorial3 =>
      locale?.tutorial3 ??
      'In the group addition window, you can specify a specific number for it.';
  String get tutorial4 =>
      locale?.tutorial4 ??
      'In the subject addition window, you can specify a specific name, room number, and teacher\'s name.';
  String get tutorial5 =>
      locale?.tutorial5 ??
      'When you click on the subject window, you can change the data in it.';
  String get tutorial6 =>
      locale?.tutorial6 ??
      'When you click on the group window, you can change its name.';

  // ManageGroupDialog
  String get groupNumber => locale?.groupNumber ?? 'Group number';
  String get groupNumberHint => locale?.groupNumberHint ?? 'Enter group number';
  String get groupNumberWrong =>
      locale?.groupNumberWrong ?? 'Group number is wrong';

  String get youRemoving =>
      locale?.youAreRemovingGroup ?? "You're removing the group";
  String get thisAction =>
      locale?.thisActionCannotBeUndone ?? "This action cannot be undone.";
  String removeGroupConfirmationDescription(String group) {
    return "$youRemoving: $group.\n\n$thisAction";
  }

  // ManageSubjectDialog
  String get addSubject => locale?.addSubject ?? 'Add subject';
  String get editSubject => locale?.editSubject ?? 'Edit subject';
  String get isDivided => locale?.isDivided ?? 'is divided';
  String get subject => locale?.subject ?? 'subject';
  String get evenWeek => locale?.evenWeek ?? 'Even Week';
  String get oddWeek => locale?.oddWeek ?? 'Odd Week';

  String get subjectHint => locale?.subjectHint ?? 'Enter subject name';
  String get cabinetNumberHint =>
      locale?.cabinetNumberHint ?? 'Enter cabinet number';
  String get teacherNameHint => locale?.teacherNameHint ?? 'Enter teacher name';

  String get subjectNameWrong =>
      locale?.subjectNameWrong ?? 'Subject name is wrong';
  String get cabinetNumberWrong =>
      locale?.cabinetNumberWrong ?? 'Cabinet number is wrong';
  String get teacherNameWrong =>
      locale?.teacherNameWrong ?? 'Teacher name is wrong';

  // ManageUserDialog
  String get areYouSureRemoveUser =>
      locale?.areYouSureRemoveUser ??
      "Are you sure you want to remove the user";
  String get user => locale?.user ?? 'User';
  String get removedSuccessfully =>
      locale?.removedSuccessfully ?? 'Removed successfully';
  String get addUser => locale?.addUser ?? 'Add User';
  String get nameWrong => locale?.nameWrong ?? 'Name is wrong';
  String get emailAlreadyExists => locale?.emailAlreadyExists ?? 'That email is already exists';
  String get selectAtLeastOneGroup => locale?.selectAtLeastOneGroup ?? 'Select at least one group';
}
