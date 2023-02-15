// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:bingnuos_admin_panel/models/schedule/subject.dart';

class Schedule {
  final String group;
  final List<Subject>? monday;
  final List<Subject>? tuesday;
  final List<Subject>? wednesday;
  final List<Subject>? thursday;
  final List<Subject>? friday;

  Schedule({
    required this.group,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
  });

  Schedule copyWith({
    String? group,
    List<Subject>? monday,
    List<Subject>? tuesday,
    List<Subject>? wednesday,
    List<Subject>? thursday,
    List<Subject>? friday,
  }) {
    return Schedule(
      group: group ?? this.group,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'group': group,
      'monday': monday?.map((x) => x.toMap()).toList(),
      'tuesday': tuesday?.map((x) => x.toMap()).toList(),
      'wednesday': wednesday?.map((x) => x.toMap()).toList(),
      'thursday': thursday?.map((x) => x.toMap()).toList(),
      'friday': friday?.map((x) => x.toMap()).toList(),
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      group: map['group'] as String,
      monday: map['monday'] != null
          ? List<Subject>.from(map['monday'].map((x) => Subject.fromMap(x)))
          : null,
      tuesday: map['tuesday'] != null
          ? List<Subject>.from(map['tuesday'].map((x) => Subject.fromMap(x)))
          : null,
      wednesday: map['wednesday'] != null
          ? List<Subject>.from(map['wednesday'].map((x) => Subject.fromMap(x)))
          : null,
      thursday: map['thursday'] != null
          ? List<Subject>.from(map['thursday'].map((x) => Subject.fromMap(x)))
          : null,
      friday: map['friday'] != null
          ? List<Subject>.from(map['friday'].map((x) => Subject.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Schedule(group: $group, monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday)';
  }

  @override
  bool operator ==(covariant Schedule other) {
    if (identical(this, other)) return true;

    return other.group == group &&
        const ListEquality().equals(other.monday, monday) &&
        const ListEquality().equals(other.tuesday, tuesday) &&
        const ListEquality().equals(other.wednesday, wednesday) &&
        const ListEquality().equals(other.thursday, thursday) &&
        const ListEquality().equals(other.friday, friday);
  }

  @override
  int get hashCode {
    return group.hashCode ^
        monday.hashCode ^
        tuesday.hashCode ^
        wednesday.hashCode ^
        thursday.hashCode ^
        friday.hashCode;
  }
}
