import 'package:chat_app/features/auth/domain/error/user_password_invalid.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:dartz/dartz.dart';
import 'package:loggy/loggy.dart';

import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/platform/network_info.dart';
import 'package:chat_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:chat_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chat_app/features/auth/domain/entities/user_session.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/data/extensions/cube_session.dart';

class AuthRepositoryImpl with UiLoggy implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserSession>> login(
      String username, String? password) async {
    if (!await networkInfo.isConnected) {
      return const Left(InternetFailure());
    }

    try {
      loggy.info('Logging user $username');
      final userSession = await authRemoteDataSource.login(username, password!);
      authLocalDataSource.cacheUserSession(userSession);

      return Right(userSession.mapCubSessionToUserSession());
    } on ResponseException catch (e) {
      return const Left(UserPasswordInvalid());
    } catch (e) {
      loggy.error('Server exception', e.toString());
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserSession>> restoreSession() async {
    if (!await networkInfo.isConnected) {
      return const Left(InternetFailure());
    }

    final userSession = await authLocalDataSource.getUser();
    if (userSession != null) {
      loggy.debug('User session cached');

      loggy.info(
        'Session for userId= ${userSession.userId} is trying to restore it',
      );
      final remoteUser = await authRemoteDataSource.restoreSession(
        userSession.mapCubSessionToUserSession(),
      );

      authLocalDataSource.cacheUserSession(remoteUser);

      return Right(remoteUser.mapCubSessionToUserSession());
    } else {
      loggy.debug('User session not exist');
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> register(String username, String? password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
