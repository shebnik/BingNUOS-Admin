// ignore_for_file: constant_identifier_names

// HIVE KEYS
const USER_BOX_KEY = 'USER_BOX';
const LANGUAGE_BOX_KEY = 'LANGUAGE_BOX';
const USER_KEY = 'USER';
const LANGUAGE_KEY = 'LANGUAGE';

const String notesURL =
    'https://docs.google.com/spreadsheets/d/1osOdvIZVKnSLiu54o9HFEyu5s_b5RFe3cblzhliRHHI';

const String fontMontserrat = 'Montserrat';
const String loginError = 'Login error';

const String loginLoc = '/login';
const String resetPasswordLoc = '/reset-password';
const String rootLoc = '/';

const String admin = 'admin';
const String moderator = 'moderator';

const List<String> subjectTimes = [
  '09:00-10:20',
  '10:30-11:50',
  '12:20-13:40',
  '13:50-15:10',
  '15:20-16:40',
  '16:50-18:10',
];

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
}

enum SubjectType {
  subject,
  evenSubject,
  oddSubject,
}

enum SubjectControllerType {
  name,
  teacher,
  cabinet,
}
