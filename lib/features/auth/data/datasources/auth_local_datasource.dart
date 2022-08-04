import 'dart:convert';

import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  static const keyUserSaved = 'user_saved_key';
  Future<CubeSession?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userSessionJson = prefs.getString(AuthLocalDataSource.keyUserSaved);

    if (userSessionJson != null) {
      CubeSession? userSession =
          CubeSession.fromJson(jsonDecode(userSessionJson));
      return userSession;
    }
    return null;
  }

  Future<void> cacheUserSession(CubeSession userSession) async {
    final prefs = await SharedPreferences.getInstance();
    final userSessionJson = userSession.toJson();
    await prefs.setString(
      AuthLocalDataSource.keyUserSaved,
      jsonEncode(userSessionJson),
    );
  }
}
