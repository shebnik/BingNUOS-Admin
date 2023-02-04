import 'dart:async';
import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/models/app_user/app_user.dart';
import 'package:bingnuos_admin_panel/models/schedule/schedule.dart';
import 'package:bingnuos_admin_panel/models/schedule/subject_info.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:bingnuos_admin_panel/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Path
  static const String _usersPath = 'users';
  static const String _schedulesPath = 'schedules';

  // Roles
  static const String _adminRole = 'admin';
  static const String _moderatorRole = 'moderator';

  // Collection references
  static final CollectionReference<AppUser> _users =
      _firestore.collection(_usersPath).withConverter(
            fromFirestore: (snapshot, _) =>
                AppUser.fromMap(snapshot.data() as Map<String, dynamic>),
            toFirestore: (user, _) => user.toMap(),
          );

  static final CollectionReference<Schedule> _schedules =
      _firestore.collection(_schedulesPath).withConverter(
            fromFirestore: (snapshot, _) =>
                Schedule.fromMap(snapshot.data() as Map<String, dynamic>),
            toFirestore: (schedule, _) => schedule.toMap(),
          );

  static Future<void> addUser(AppUser user) =>
      _users.doc(user.userId).set(user);

  static Future<AppUser> getUser(String id) =>
      _users.doc(id).get().then((snapshot) => snapshot.data()!);

  static Future<bool> userExists(String id) =>
      _users.doc(id).get().then((doc) => doc.exists);

  Stream<DocumentSnapshot> listenUserData(String userId) {
    return _firestore.collection(_usersPath).doc(userId).snapshots();
  }

  Stream<QuerySnapshot> listenSchedules(AppUser user) {
    if (user.role == _adminRole) {
      return _firestore.collection(_schedulesPath).snapshots();
    }
    return _firestore
        .collection(_schedulesPath)
        .where('group', whereIn: user.moderationGroups)
        .snapshots();
  }

  static Future<bool> deleteGroup(String group) =>
      _schedules.doc(group).delete().then((value) => true).catchError((error) {
        Logger.e('[deleteGroup] Error', error);
        return false;
      });

  static Future<bool> manageGroup(String newGroupName, [String? group]) async {
    try {
      if (group != null) {
        await _schedules.doc(group).delete();
      } else {
        await _schedules.doc(newGroupName).set(
              Schedule(
                group: newGroupName,
              ),
            );
      }
      return true;
    } catch (e) {
      Logger.e('[manageGroup] Error', e);
      return false;
    }
  }

  static Future<bool> setSchedule({
    required String group,
    required Schedule schedule,
  }) async {
    return _schedules
        .doc(group)
        .set(schedule, SetOptions(merge: true))
        .then((value) => true)
        .catchError((error) {
      Logger.e('[setSchedule] Error', error);
      return false;
    });
  }

  static Future<bool> addSchedule({
    required String group,
    required WeekDay weekDay,
    required SubjectInfo subjectInfo,
  }) async {
    final arrayPath = Utils.arrayPathFromWeekDay(weekDay);
    return _schedules
        .doc(group)
        .update({
          arrayPath: FieldValue.arrayUnion([subjectInfo.toJson()])
        })
        .then((value) => true)
        .catchError((error) {
          Logger.e('[addSchedule] Error', error);
          return false;
        });
  }

  static Future<bool> removeSchedule({
    required String group,
    required WeekDay weekDay,
    required SubjectInfo subjectInfo,
  }) async {
    final arrayPath = Utils.arrayPathFromWeekDay(weekDay);
    return _schedules
        .doc(group)
        .update({
          arrayPath: FieldValue.arrayRemove([subjectInfo.toJson()])
        })
        .then((value) => true)
        .catchError((error) {
          Logger.e('[removeSchedule] Error', error);
          return false;
        });
  }

  static Future<bool> updateSchedule({
    required String group,
    required WeekDay weekDay,
    required SubjectInfo subjectInfo,
    required SubjectInfo fieldSubjectInfo,
  }) async {
    // try {
    //   final arrayPath = Utils.arrayPathFromWeekDay(day);

    //   if (await _service.arrayRemove(
    //     path: FirestorePath.scheduleDoc(group),
    //     data: scheduleInfo.toJson(),
    //     arrayPath: arrayPath,
    //   )) {
    //     if (await _service.arrayUnion(
    //       path: FirestorePath.scheduleDoc(group),
    //       data: fieldScheduleInfo.toJson(),
    //       arrayPath: arrayPath,
    //     )) {
    //       return true;
    //     }
    //     return false;
    //   }
    //   return false;
    // } catch (e) {
    //   Logger.e('updateSchedule error: ', e);
    //   return false;
    // }

    final arrayPath = Utils.arrayPathFromWeekDay(weekDay);
    return _schedules
        .doc(group)
        .update({
          arrayPath: FieldValue.arrayRemove([subjectInfo.toJson()]),
          arrayPath: FieldValue.arrayUnion([fieldSubjectInfo.toJson()])
        })
        .then((value) => true)
        .catchError((error) {
          Logger.e('[updateSchedule] Error', error);
          return false;
        });
  }
}
