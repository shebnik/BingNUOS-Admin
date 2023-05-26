import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/models/app_user/app_user.dart';
import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/services/firebase/functions_service.dart';
import 'package:bingnuos_admin_panel/ui/dialogs/are_you_sure/are_you_sure.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'manage_user.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  late final FunctionsService _functionsService;

  @override
  void initState() {
    _functionsService = FunctionsService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.of(context).manageUsers),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.go(rootLoc);
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: AppLocale.of(context).addUser,
            onPressed: () => _manageUser(),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: FirestoreService.getModerators(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<AppUser> moderators = snapshot.data as List<AppUser>;
              return ListView.separated(
                itemCount: moderators.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  AppUser moderator = moderators[index];
                  String moderatorGroups =
                      moderator.moderationGroups?.isNotEmpty == true
                          ? moderator.moderationGroups!.join(", ")
                          : "";
                  return ListTile(
                    title: Text(moderator.name),
                    subtitle: Text("${moderator.email}\n$moderatorGroups"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _manageUser(moderator),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeUser(moderator),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _manageUser([AppUser? user]) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ManageUser(
        type: user == null ? ManageUserType.add : ManageUserType.edit,
        user: user,
        key: UniqueKey(),
      ),
    );
  }

  Future<void> _removeUser(AppUser user) async {
    bool result = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AreYouSure(
            description:
                '${AppLocale.of(context).areYouSureRemoveUser} "${user.name}"?\n\n${AppLocale.of(context).thisAction}',
          ),
        ) ??
        false;
    if (result != true) return;
    await _functionsService.removeUser(user.userId);
    if(!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${AppLocale.of(context).user} "${user.name}" ${AppLocale.of(context).removedSuccessfully}',
        ),
      ),
    );
  }
}
