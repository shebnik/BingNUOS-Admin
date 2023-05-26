import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  static final _database = FirebaseDatabase.instance;

  static Future<List<String>> getAllGroups() async {
    final groups = <String>[];
    final snapshot = await _database.ref("/groups").get();
    final groupList = snapshot.value as Map<dynamic, dynamic>;
    groupList.forEach((key, value) {
      groups.add(value['group']);
    });
    return groups.sorted((a, b) => a.compareTo(b));
  }
}
