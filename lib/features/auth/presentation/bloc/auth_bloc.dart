import 'package:bloc/bloc.dart';
import 'package:chat_app/features/auth/domain/entities/user.dart';
import 'package:chat_app/features/auth/domain/usecases/login.dart';
import 'package:chat_app/features/auth/domain/usecases/register.dart';

import 'package:equatable/equatable.dart';
import 'package:loggy/loggy.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with UiLoggy {
  final Login login;
  final Register register;
  AuthBloc({
    required this.login,
    required this.register,
  }) : super(LoginInitial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  void _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());

    loggy.info('Logging user ${event.username}');
    final failureOrUser = await login.execute(
      User(username: event.username, password: event.password),
    );

    emit(
      failureOrUser.fold(
        (failure) => LoginError(failure.message),
        (userSession) => LoginSuccess(username: userSession.user!.username),
      ),
    );
  }
}
