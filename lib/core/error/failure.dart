import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);
  final String message;

  @override
  List<Object> get props => [];
}

// General failures
class InternetFailure extends Failure {
  const InternetFailure() : super("No internet connection!");
}

class ServerFailure extends Failure {
  const ServerFailure() : super("An error occurred on the server");
}

class CacheFailure extends Failure {
  const CacheFailure() : super("Cache error");
}
