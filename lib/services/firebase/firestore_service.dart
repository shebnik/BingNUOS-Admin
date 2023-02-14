import 'dart:async';
import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/models/app_user/app_user.dart';
import 'package:bingnuos_admin_panel/models/schedule/schedule.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject_info.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collections
  static const String _usersCollectionPath = 'users';
  static const String _schedulesCollectionPath = 'schedules';

  // Fields
  static const String _adminRoleField = 'admin';
  static const String _moderatorRoleField = 'moderator';
  static const String _groupField = 'group';
  static const String _moderationGroupsField = 'moderationGroups';

  // Collection references
  static final CollectionReference<AppUser> _users =
      _firestore.collection(_usersCollectionPath).withConverter(
            fromFirestore: (snapshot, _) =>
                AppUser.fromMap(snapshot.data() as Map<String, dynamic>),
            toFirestore: (user, _) => user.toMap(),
          );

  static final CollectionReference<Schedule> _schedules =
      _firestore.collection(_schedulesCollectionPath).withConverter(
            fromFirestore: (snapshot, _) =>
                Schedule.fromMap(snapshot.data() as Map<String, dynamic>),
            toFirestore: (schedule, _) => schedule.toMap(),
          );

  Stream<DocumentSnapshot> listenUserData(String userId) {
    return _firestore.collection(_usersCollectionPath).doc(userId).snapshots();
  }

  Stream<QuerySnapshot> listenSchedules(AppUser user) {
    if (user.role == _adminRoleField) {
      Logger.i('[listenSchedules] Admin');
      return _firestore.collection(_schedulesCollectionPath).snapshots();
    }
    if (user.moderationGroups == null || user.moderationGroups!.isEmpty) {
      Logger.i('[listenSchedules] No moderation groups');
      return const Stream.empty();
    }
    
    return _firestore
        .collection(_schedulesCollectionPath)
        .where(_groupField, whereIn: user.moderationGroups)
        .snapshots();
  }

  static Future<bool> setGroupSchedule(Schedule schedule) {
    return _schedules
        .doc()
        .set(schedule)
        .then((value) => true)
        .catchError((error) {
      Logger.e('[addGroup] Error', error);
      return false;
    });
  }

  static Future<bool> deleteScheduleGroup(String group) {
    return _schedules
        .where(_groupField, isEqualTo: group)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.first.reference.delete().then((value) => true);
      } else {
        Logger.d('[deleteScheduleGroup] Group: $group not found');
        return Future.value(false);
      }
    }).catchError((error) {
      Logger.e('[deleteScheduleGroup] Error', error);
      return false;
    });
  }

  static Future<bool> renameScheduleGroup({
    required String group,
    required String newGroupName,
  }) {
    return _schedules
        .where(_groupField, isEqualTo: group)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.first.reference
            .update({_groupField: newGroupName}).then((value) => true);
      } else {
        Logger.d('[renameGroup] Group: $group not found');
        return Future.value(false);
      }
    }).catchError((error) {
      Logger.e('[renameGroup] Error', error);
      return false;
    });
  }

  static Future<bool> addSchedule({
    required String group,
    required WeekDay weekDay,
    required Subject subject,
  }) {
    final arrayPath = Utils.arrayPathFromWeekDay(weekDay);
    return _schedules
        .where(_groupField, isEqualTo: group)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.first.reference.update({
          arrayPath: FieldValue.arrayUnion([subject.toMap()])
        }).then((value) => true);
      } else {
        Logger.d('[addSchedule] Group: $group not found');
        return Future.value(false);
      }
    }).catchError((error) {
      Logger.e('[addSchedule] Error', error);
      return false;
    });
  }

  static Future<bool> removeSchedule({
    required String group,
    required WeekDay weekDay,
    required Subject subject,
  }) {
    final arrayPath = Utils.arrayPathFromWeekDay(weekDay);
    return _schedules
        .where(_groupField, isEqualTo: group)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.first.reference.update({
          arrayPath: FieldValue.arrayRemove([subject.toMap()])
        }).then((value) => true);
      } else {
        Logger.d('[removeSchedule] Group: $group not found');
        return Future.value(false);
      }
    }).catchError((error) {
      Logger.e('[removeSchedule] Error', error);
      return false;
    });
  }

  static Future<bool> updateSchedule({
    required String group,
    required WeekDay weekDay,
    required Subject subject,
    required Subject fieldSubject,
  }) {
    final arrayPath = Utils.arrayPathFromWeekDay(weekDay);
    return _schedules
        .where(_groupField, isEqualTo: group)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.first.reference
            .update({
              arrayPath: FieldValue.arrayRemove([subject.toMap()]),
            })
            .then((_) => _schedules
                .doc(group)
                .update({
                  arrayPath: FieldValue.arrayUnion([fieldSubject.toMap()])
                })
                .then((__) => true)
                .catchError((error) {
                  Logger.e('[updateSchedule] arrayUnion Error', error);
                  return false;
                }))
            .catchError((error) {
              Logger.e('[updateSchedule] arrayRemove Error', error);
              return false;
            });
      } else {
        Logger.d('[updateSchedule] Group: $group not found');
        return Future.value(false);
      }
    }).catchError((error) {
      Logger.e('[updateSchedule] Error', error);
      return false;
    });
  }

  static Future<bool> addUserModerationGroup(String userId, String group) {
    return _users
        .doc(userId)
        .update({
          _moderationGroupsField: FieldValue.arrayUnion([group])
        })
        .then((value) => true)
        .catchError((error) {
          Logger.e('[addUserModerationGroup] Error', error);
          return false;
        });
  }

  static Future<bool> removeUserModerationGroup(String userId, String group) {
    return _users
        .doc(userId)
        .update({
          _moderationGroupsField: FieldValue.arrayRemove([group])
        })
        .then((value) => true)
        .catchError((error) {
          Logger.e('[removeUserModerationGroup] Error', error);
          return false;
        });
  }
}
