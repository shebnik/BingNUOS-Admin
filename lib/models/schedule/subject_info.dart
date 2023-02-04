// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubjectInfo {
  final String cabinet;
  final String name;
  final String teacher;

  SubjectInfo({
    required this.cabinet,
    required this.name,
    required this.teacher,
  });

  SubjectInfo copyWith({
    String? cabinet,
    String? name,
    String? teacher,
  }) {
    return SubjectInfo(
      cabinet: cabinet ?? this.cabinet,
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cabinet': cabinet,
      'name': name,
      'teacher': teacher,
    };
  }

  factory SubjectInfo.fromMap(Map<String, dynamic> map) {
    return SubjectInfo(
      cabinet: map['cabinet'] as String,
      name: map['name'] as String,
      teacher: map['teacher'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectInfo.fromJson(String source) =>
      SubjectInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubjectInfo(cabinet: $cabinet, name: $name, teacher: $teacher)';

  @override
  bool operator ==(covariant SubjectInfo other) {
    if (identical(this, other)) return true;

    return other.cabinet == cabinet &&
        other.name == name &&
        other.teacher == teacher;
  }

  @override
  int get hashCode => cabinet.hashCode ^ name.hashCode ^ teacher.hashCode;
}
