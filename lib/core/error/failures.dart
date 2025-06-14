import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}

// Add other specific failures as needed, e.g.:
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No Internet Connection']);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure([super.message = 'Invalid Input']);
}

// // Custom exception for data layer
// class ServerException implements Exception {
//   final String message;
//   const ServerException(this.message);
// }