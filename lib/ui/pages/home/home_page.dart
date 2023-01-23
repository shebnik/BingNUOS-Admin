import 'package:bingnuos_admin_panel/models/app_user.dart';
import 'package:bingnuos_admin_panel/services/hive_service.dart';
import 'package:bingnuos_admin_panel/ui/components/home/app_bar/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userBoxListenableBuilder = ValueListenableBuilder(
        valueListenable: Provider.of<HiveService>(context).userBoxListenable,
        builder: (context, Box<AppUser> userBox, _) {
          final appUser = userBox.get(HiveService.USER_KEY);
          if (appUser == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome, ${appUser.name}'),
                Text('Email: ${appUser.email}'),
                Text('User ID: ${appUser.userId}'),
                Text('Role: ${appUser.role}'),
                if (appUser.moderationGroups != null) ...[
                  const Text('Moderation Groups: '),
                  for (final group in appUser.moderationGroups!) Text(group),
                ],
              ],
            ),
          );
        },
      );
    return Scaffold(
      appBar: const HomePageAppBar(),
      body: userBoxListenableBuilder,
    );
  }
}
