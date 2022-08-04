import 'package:connectycube_sdk/connectycube_whiteboard.dart';
import 'package:loggy/loggy.dart';

import 'package:chat_app/features/auth/domain/entities/user_session.dart';

class AuthRemoteDataSource with UiLoggy {
  Future<CubeSession> login(String username, String? password) async {
    loggy.debug('$username - $password');
    final session = await createSession(
      CubeUser(login: username, password: password),
    );

    return session;
  }

  Future<CubeSession> restoreSession(UserSession userSession) async {
    return await login(userSession.user!.username, userSession.token);
  }
}
