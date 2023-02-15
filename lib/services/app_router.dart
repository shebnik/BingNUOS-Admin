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
    redirect: (context, state) {
      final bool loggingIn =
          state.subloc == loginLoc || state.subloc == resetPasswordLoc;
      final bool loggedIn = firebaseUser.value != null;

      if (!loggedIn && !loggingIn) {
        Logger.i('redirecting to login page');
        return loginLoc;
      }
      if (loggedIn) {
        Logger.i('redirecting to root page');
        return rootLoc;
      }
      return null;
    },
    debugLogDiagnostics: true,
    routes: [
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
