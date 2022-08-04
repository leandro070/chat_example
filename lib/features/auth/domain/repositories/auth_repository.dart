import 'package:chat_app/features/auth/domain/entities/user_session.dart';
import 'package:dartz/dartz.dart';

import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserSession>> login(String username, String? password);
  Future<Either<Failure, bool>> register(String username, String? password);
  Future<Either<Failure, UserSession>> restoreSession();
}
