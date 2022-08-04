import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Register {
  AuthRepository authRepository;

  Register(this.authRepository);

  Future<Either<Failure, bool>> execute(User user) async {
    return await authRepository.register(user.username, user.password);
  }
}
