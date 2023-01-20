import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/ui/pages/auth/login_view.dart';
import 'package:bingnuos_admin_panel/ui/pages/error_page.dart';
import 'package:bingnuos_admin_panel/ui/pages/logged_in_view.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final ValueListenable<User?> firebaseUser;

  AppRouter(this.firebaseUser);

  late final router = GoRouter(
    refreshListenable: firebaseUser,
    redirect: (context, state) {
      final bool loggingIn = state.subloc == loginLoc;
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
        path: '/',
        builder: (context, routerState) => const LoggedInView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, routerState) => const LoginView(),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
  );
}
