import 'package:chat_app/core/error/failure.dart';

class UserPasswordInvalid extends Failure {
  const UserPasswordInvalid() : super("Usuario o password invalido");
}
