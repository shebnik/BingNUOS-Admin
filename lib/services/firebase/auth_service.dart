import 'dart:async';

import 'package:bingnuos_admin_panel/utils/app_locale.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<Map<bool, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Logger.i(
          '[signInWithEmailAndPassword] User: ${_auth.currentUser!.email} is logged in!');
      return {
        true: "success",
      };
    } on FirebaseAuthException catch (e) {
      Logger.e('[signInWithEmailAndPassword] FirebaseAuthException: ', e);
      return {
        false: e.toString(),
      };
    } catch (e) {
      Logger.e('[signInWithEmailAndPassword] error', e);
      return {
        false: e.toString(),
      };
    }
  }

  String getFirebaseAuthErrorMessage(String errorString, context) {
    String errorCode = errorString
        .substring(errorString.indexOf("[") + 1, errorString.indexOf("]"))
        .replaceAll("firebase_auth/", "");
    switch (errorCode) {
      case 'invalid-email':
      case 'user-not-found':
        return AppLocale(context).emailWrong;
      case 'wrong-password':
        return AppLocale(context).passwordWrong;
      default:
        return errorString.substring(errorString.indexOf("] ") + 2);
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
