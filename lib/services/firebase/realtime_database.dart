import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  static final _database = FirebaseDatabase.instance;

  static Future<Map<String, String>> getAllGroups() async {
    final snapshot = await _database.ref("/groups").get();
    final groupList = snapshot.value as Map<dynamic, dynamic>;

    Map<String, String> groupMap = groupList.map<String, String>((key, value) =>
        MapEntry<String, String>(value['docId'], value['group']));

    return Map.fromEntries(
      groupMap.entries.toList()
        ..sort(
          (a, b) => a.value.compareTo(b.value),
        ),
    );
  }
}
