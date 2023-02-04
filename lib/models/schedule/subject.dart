// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bingnuos_admin_panel/models/schedule/subject_info.dart';

class Subject {
  final bool isDivided;
  final int number;
  final SubjectInfo? evenSubject;
  final SubjectInfo? oddSubject;
  final SubjectInfo? subject;

  Subject({
    required this.isDivided,
    required this.number,
    this.evenSubject,
    this.oddSubject,
    this.subject,
  }) : assert(isDivided
            ? evenSubject != null && oddSubject != null
            : subject != null);

  Subject copyWith({
    bool? isDivided,
    int? number,
    SubjectInfo? evenSubject,
    SubjectInfo? oddSubject,
    SubjectInfo? subject,
  }) {
    return Subject(
      isDivided: isDivided ?? this.isDivided,
      number: number ?? this.number,
      evenSubject: evenSubject ?? this.evenSubject,
      oddSubject: oddSubject ?? this.oddSubject,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isDivided': isDivided,
      'number': number,
      'evenSubject': evenSubject?.toMap(),
      'oddSubject': oddSubject?.toMap(),
      'subject': subject?.toMap(),
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      isDivided: map['isDivided'] as bool,
      number: map['number'] as int,
      evenSubject: map['evenSubject'] != null
          ? SubjectInfo.fromMap(map['evenSubject'] as Map<String, dynamic>)
          : null,
      oddSubject: map['oddSubject'] != null
          ? SubjectInfo.fromMap(map['oddSubject'] as Map<String, dynamic>)
          : null,
      subject: map['subject'] != null
          ? SubjectInfo.fromMap(map['subject'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Subject(isDivided: $isDivided, number: $number, evenSubject: $evenSubject, oddSubject: $oddSubject, subject: $subject)';
  }

  @override
  bool operator ==(covariant Subject other) {
    if (identical(this, other)) return true;

    return other.isDivided == isDivided &&
        other.number == number &&
        other.evenSubject == evenSubject &&
        other.oddSubject == oddSubject &&
        other.subject == subject;
  }

  @override
  int get hashCode {
    return isDivided.hashCode ^
        number.hashCode ^
        evenSubject.hashCode ^
        oddSubject.hashCode ^
        subject.hashCode;
  }
}
