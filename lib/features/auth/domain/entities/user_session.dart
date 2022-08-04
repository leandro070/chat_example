import 'package:chat_app/features/auth/domain/entities/user.dart';

class UserSession {
  String? token;
  int? appId;
  int? userId;
  User? user;
  int? deviceId;
  int? timestamp;
  DateTime? tokenExpirationDate;

  UserSession({
    this.token,
    this.appId,
    this.deviceId,
    this.timestamp,
    this.tokenExpirationDate,
    this.user,
    this.userId,
  });
}
