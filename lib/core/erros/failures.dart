import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class NoParams extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyParamFailure extends Failure {
  @override
  List<Object?> get props => [];
}
