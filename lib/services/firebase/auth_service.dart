import 'dart:async';

import 'package:bingnuos_admin_panel/services/snackbar_service.dart';
import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get user => _auth.currentUser;

  bool get isSignedIn => _auth.currentUser != null;

  void initialize() {
    authStateChanges.listen((User? user) {
      if (user == null) {
        Logger.i('User is currently signed out!');
      } else {
        Logger.i('User is signed in!');
      }
    });
  }

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Logger.i('user: ${_auth.currentUser!.email} is logged in!');
      return true;
    } on FirebaseAuthException catch (e) {
      Logger.e('logIn error', e);
      SnackBarService(context).show(getFirebaseAuthErrorMessage(e, context));
    } catch (e) {
      Logger.e('logIn error', e);
      SnackBarService(context).show(loginError);
    }

    return false;
  }

  String getFirebaseAuthErrorMessage(e, context) {
    String extractedMessage = e.toString().split("(")[1].split(")")[0];
    String code = extractedMessage.split("/")[1];
    switch (code) {
      case 'invalid-email':
      case 'user-not-found':
        return AppLocale(context).emailWrong;
      case 'wrong-password':
        return AppLocale(context).passwordWrong;
      default:
        final match = RegExp(r"Firebase: (.*?)\(").firstMatch(e.toString());
        return match?.group(1) ?? loginError;
    }
  }

  Future<void> signOut() async {
    Logger.i('Signing out');
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
