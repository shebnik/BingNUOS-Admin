// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'app_user.g.dart';

@HiveType(typeId: 0)
class AppUser extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String userId;

  @HiveField(3)
  final String role;

  @HiveField(4)
  final List<String>? moderationGroups;

  AppUser({
    required this.name,
    required this.email,
    required this.userId,
    required this.role,
    this.moderationGroups,
  });

  AppUser copyWith({
    String? name,
    String? email,
    String? userId,
    String? role,
    List<String>? moderationGroups,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      moderationGroups: moderationGroups ?? this.moderationGroups,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'userId': userId,
      'role': role,
      'moderationGroups': moderationGroups,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] as String,
      email: map['email'] as String,
      userId: map['userId'] as String,
      role: map['role'] as String,
      moderationGroups: map['moderationGroups'] != null
          ? List<String>.from(map['moderationGroups'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(name: $name, email: $email, userId: $userId, role: $role, moderationGroups: $moderationGroups)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.name == name &&
        other.email == email &&
        other.userId == userId &&
        other.role == role &&
        listEquals(other.moderationGroups, moderationGroups);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        userId.hashCode ^
        role.hashCode ^
        moderationGroups.hashCode;
  }

  static AppUser empty() {
    return AppUser(
      name: '',
      email: '',
      userId: '',
      role: '',
      moderationGroups: [],
    );
  }
}
