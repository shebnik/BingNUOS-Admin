import 'package:bingnuos_admin_panel/services/firebase/firestore_service.dart';
import 'package:bingnuos_admin_panel/ui/pages/manage_users/manage_users_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/ui/pages/auth/login_view.dart';
import 'package:bingnuos_admin_panel/ui/pages/auth/reset_password_view.dart';
import 'package:bingnuos_admin_panel/ui/pages/error_page.dart';
import 'package:bingnuos_admin_panel/ui/pages/home/logged_in_view.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';

class AppRouter {
  final ValueListenable<User?> firebaseUser;

  AppRouter(this.firebaseUser);

  late final router = GoRouter(
    refreshListenable: firebaseUser,
    redirect: (context, state) async {
      final bool loggingIn =
          state.subloc == loginLoc || state.subloc == resetPasswordLoc;
      final bool loggedIn = firebaseUser.value != null;

      if (!loggedIn && !loggingIn) {
        Logger.i('redirecting to login page');
        return loginLoc;
      }
      if (loggedIn && state.subloc != manageUsersLoc) {
        Logger.i('redirecting to root page');
        return rootLoc;
      }
      if (state.subloc == manageUsersLoc &&
          (await FirestoreService.getUserById(firebaseUser.value!.uid)).role ==
              moderator) {
        Logger.i('redirecting to root page');
        return rootLoc;
      }
      return null;
    },
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: manageUsersLoc,
        builder: (context, routerState) => const ManageUsersPage(),
      ),
      GoRoute(
        path: rootLoc,
        builder: (context, routerState) => const LoggedInView(),
      ),
      GoRoute(
        path: loginLoc,
        builder: (context, routerState) => const LoginView(),
      ),
      GoRoute(
        path: resetPasswordLoc,
        builder: (context, routerState) => const ResetPasswordView(),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
  );
}
