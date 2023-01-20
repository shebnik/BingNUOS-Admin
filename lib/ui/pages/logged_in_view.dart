import 'package:bingnuos_admin_panel/services/firebase/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoggedInView extends StatefulWidget {
  const LoggedInView({super.key});

  @override
  State<LoggedInView> createState() => _LoggedInViewState();
}

class _LoggedInViewState extends State<LoggedInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Logged In ${context.watch<AuthService>().user?.email}"),
          ElevatedButton(
            onPressed: () {
              context.read<AuthService>().signOut();
            },
            child: Text("Log Out"),
          ),
        ],
      ),
    );
  }
}
