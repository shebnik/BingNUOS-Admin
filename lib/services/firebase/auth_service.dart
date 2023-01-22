import 'dart:async';

import 'package:bingnuos_admin_panel/services/snackbar_service.dart';
import 'package:bingnuos_admin_panel/constants.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get user => _auth.currentUser;

  bool get isSignedIn => _auth.currentUser != null;

  AuthService() {
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
      if (e.code == 'user-not-found') {
        Logger.i('No user found for that email.');
        SnackBarService(context).show('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Logger.i('Wrong password provided for that user.');
        SnackBarService(context).show('Wrong password provided for that user.');
      } else {
        Logger.e('createAccount error:', e);
        SnackBarService(context).show(e.message ?? loginError);
      }
    } catch (e) {
      Logger.e('logIn error', e);
    }

    return false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
