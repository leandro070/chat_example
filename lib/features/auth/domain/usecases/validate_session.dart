import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/auth/domain/entities/user_session.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ValidateSession {
  AuthRepository authRepository;

  ValidateSession(this.authRepository);

  Future<Either<Failure, UserSession>> execute() async {
    return await authRepository.restoreSession();
  }
}
