import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/auth/domain/entities/user_session.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';

extension CubeSessionX on CubeSession {
  UserSession mapCubSessionToUserSession() {
    return UserSession(
      appId: appId,
      deviceId: deviceId,
      timestamp: timestamp,
      token: token,
      userId: userId,
      tokenExpirationDate: tokenExpirationDate,
      user: User(
        username: user!.login ?? '',
        avatar: user!.avatar,
        customData: user!.customData,
        email: user!.email,
        password: user!.password,
        externalId: user!.externalId,
        fullName: user!.fullName,
        id: user!.id,
        login: user!.login,
        phone: user!.phone,
      ),
    );
  }
}
