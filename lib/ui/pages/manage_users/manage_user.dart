import 'package:bingnuos_admin_panel/models/app_user/app_user.dart';
import 'package:bingnuos_admin_panel/providers/search_groups_provider.dart';
import 'package:bingnuos_admin_panel/ui/components/app_text_field.dart';
import 'package:bingnuos_admin_panel/ui/components/buttons/app_elevated_button.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'manage_user_controller.dart';
import 'manage_user_search_bar.dart';

enum ManageUserType { add, edit }

class ManageUser extends StatefulWidget {
  final ManageUserType type;
  final AppUser? user;

  const ManageUser({super.key, required this.type, this.user});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  late ManageUserController _controller;

  @override
  void initState() {
    _controller = ManageUserController(
      type: widget.type,
      user: widget.user,
    );
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ManageUserGroupSearchbarProvider>().searchValue = '';
      _controller.emailTEC.text = _controller.user.value.email;
      _controller.nameTEC.text = _controller.user.value.name;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _controller.user.value.name == ''
              ? AppLocale.of(context).addUser
              : "${AppLocale.of(context).update} ${_controller.user.value.name}",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ValueListenableBuilder(
                valueListenable: _controller.isNameError,
                builder: (_, value, __) => AppTextField(
                  hintText: AppLocale.of(context).name,
                  errorText: AppLocale.of(context).nameWrong,
                  showError: value,
                  controller: _controller.nameTEC,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ValueListenableBuilder(
                valueListenable: _controller.isEmailError,
                builder: (_, value, __) => AppTextField(
                  hintText: AppLocale.of(context).email,
                  errorText: AppLocale.of(context).emailWrong,
                  showError: value,
                  controller: _controller.emailTEC,
                  enabled: widget.type == ManageUserType.add,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const ManageUserGroupSearchbar(),
            FutureBuilder(
              future: _controller.getGroups(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                _controller.updateItems(
                  context.watch<ManageUserGroupSearchbarProvider>().searchValue,
                );
                return Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _controller.filteredItems,
                    builder: (_, filtered, __) => ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return ValueListenableBuilder(
                          valueListenable: _controller.user,
                          builder: (_, u, __) {
                            return CheckboxListTile(
                              key: UniqueKey(),
                              title: Text(item),
                              value:
                                  u.moderationGroups?.contains(item) ?? false,
                              onChanged: (value) {
                                if (value ?? false) {
                                  _controller.user.value = u.copyWith(
                                    moderationGroups: [
                                      ...u.moderationGroups ?? [],
                                      item,
                                    ],
                                  );
                                } else {
                                  _controller.user.value = u.copyWith(
                                    moderationGroups: [
                                      ...u.moderationGroups ?? [],
                                    ]..remove(item),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _controller.isLoading,
                    builder: (_, isDisabled, child) {
                      return Row(
                        children: [
                          if (isDisabled)
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          AppElevatedButton(
                            title: _controller.type == ManageUserType.add
                                ? AppLocale(context).add
                                : AppLocale(context).update,
                            width: 120,
                            height: 40,
                            isDisabled: isDisabled,
                            onPressed: () async {
                              bool? res;
                              if (_controller.type == ManageUserType.add) {
                                res = await _controller.createAccount(context, mounted);
                              } else {
                                res = await _controller.updateAccount();
                              }
                              if (res == null || !mounted) return;
                              if (res) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocale(context).success,
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocale(context).somethingWentWrong,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
