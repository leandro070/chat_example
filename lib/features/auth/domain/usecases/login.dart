import 'package:chat_app/features/auth/domain/entities/user_session.dart';
import 'package:dartz/dartz.dart';
import 'package:loggy/loggy.dart';

import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';

class Login with UiLoggy {
  AuthRepository authRepository;

  Login(this.authRepository);

  Future<Either<Failure, UserSession>> execute(User user) async {
    loggy.info('Login usecase executed for user ${user.username}');
    return await authRepository.login(user.username, user.password);
  }
}
