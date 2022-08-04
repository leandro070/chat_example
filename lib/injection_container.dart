import 'package:chat_app/core/platform/network_info.dart';
import 'package:chat_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:chat_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/domain/usecases/login.dart';
import 'package:chat_app/features/auth/domain/usecases/register.dart';
import 'package:chat_app/features/auth/domain/usecases/validate_session.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart' as cb;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  Loggy.initLoggy();
  if (kDebugMode) {
    cb.CubeSettings.instance.isDebugEnabled = true;
  }

  await dotenv.load(fileName: ".env");

  // init Connectycube SDK
  cb.init(
    dotenv.get('CONNECTY_CUBE_APPLICATION_ID'),
    dotenv.get('CONNECTY_CUBE_AUTHORIZATION_KEY'),
    dotenv.get('CONNECTY_CUBE_AUTHORIZATION_SECRET'),
  );

  getIt.registerFactory(() => AuthBloc(login: getIt(), register: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => Login(getIt()));
  getIt.registerLazySingleton(() => Register(getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>((() => AuthRepositoryImpl(
        authRemoteDataSource: getIt(),
        authLocalDataSource: getIt(),
        networkInfo: getIt(),
      )));

  // Data sources
  getIt.registerLazySingleton((() => AuthLocalDataSource()));
  getIt.registerLazySingleton((() => AuthRemoteDataSource()));

  //! Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
}
