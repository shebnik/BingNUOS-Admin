import 'package:bingnuos_admin_panel/firebase_options.dart';
import 'package:bingnuos_admin_panel/utils/logger.dart';
import 'package:cloud_functions/cloud_functions.dart';

class FunctionsService {
  late FirebaseFunctions _service;

  late HttpsCallable _removeUser;
  late HttpsCallable _registerUser;

  FunctionsService() {
    _service = FirebaseFunctions.instance;

    _removeUser = _service.httpsCallableFromUrl(removeUserFunction);
    _registerUser = _service.httpsCallableFromUrl(registerUserFunction);
  }

  Future<bool> removeUser(String uid) async {
    try {
      final result = await _removeUser({
        'uid': uid,
      });
      Logger.i("[removeUser] result: ${result.data}");
      return result.data as bool;
    } catch (e) {
      Logger.e("[removeUser] error", e);
      return false;
    }
  }

  Future<Map<bool, String>> registerUser(
    String name,
    String email,
    List<String> moderationGroups,
  ) async {
    final result = await _registerUser({
      'name': name,
      'email': email,
      'moderationGroups': moderationGroups,
    });
    Logger.i("[registerUser] result: ${result.data}");
    bool success = result.data.toString().toLowerCase() == 'true';
    if (success) {
      return {
        success: '',
      };
    } else {
      return {
        success: result.data.toString(),
      };
    }
  }
}
