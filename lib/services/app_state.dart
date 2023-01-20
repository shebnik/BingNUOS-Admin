import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  AppState() {
    // _schedulesStreamController = StreamController.broadcast(onListen: () {
    // });
  }

  User? user;
  // Stream<List<Schedule>> get schedules => _schedulesStreamController.stream;
  // late final StreamController<List<Schedule>> _schedulesStreamController;

  Future<void> login(
      String email, String password, BuildContext context) async {
    
  }

  // void writeEntryToFirebase(Schedule schedule) {
  //   FirebaseFirestore.instance.collection('schedules').add(<String, String>{
  //   });
  // }

  void _listenForEntries() {
    // FirebaseFirestore.instance
    //     .collection('schedules')
    //     .snapshots()
    //     .listen((event) {
    //   final entries = event.docs.map((doc) {
    //     final data = doc.data();
    //     return Schedule(
    //       group: data['date'] as String,
    //     );
    //   }).toList();

    //   _schedulesStreamController.add(entries);
    // });
  }

  void dispose() {
    // _schedulesStreamController.close();
  }
}
