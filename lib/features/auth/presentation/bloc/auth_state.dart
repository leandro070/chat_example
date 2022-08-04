part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String username;
  const LoginSuccess({required this.username});
}

class LoginError extends AuthState {
  const LoginError(this.message);

  final String message;
}
