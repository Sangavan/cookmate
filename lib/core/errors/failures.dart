import 'package:equatable/equatable.dart';

/// Base class for all failures in the app.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Server returned an error (4xx, 5xx).
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// No internet / connection timeout.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Local cache read/write problem.
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Authentication failed (wrong credentials, expired token).
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}