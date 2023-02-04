import 'package:bingnuos_admin_panel/models/app_user/app_user.dart';
import 'package:bingnuos_admin_panel/services/firebase/auth_service.dart';
import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/services/hive_service.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/home_page.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/time_table/time_table_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoggedInView extends StatefulWidget {
  const LoggedInView({super.key});

  @override
  State<LoggedInView> createState() => _LoggedInViewState();
}

class _LoggedInViewState extends State<LoggedInView> {
  final _firestoreService = FirestoreService();
  final _hiveService = HiveService();
  late Stream<DocumentSnapshot> _userDataStream;
  late final String _userId;

  @override
  void initState() {
    _userId = context.read<AuthService>().user?.uid ?? '';
    _userDataStream = _firestoreService.listenUserData(_userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _userDataStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data!.data() as Map<String, dynamic>?;
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final appUser = AppUser.fromMap(data);
        _hiveService.saveAppUser(appUser);

        return const HomePage();
      },
    );
  }
}
