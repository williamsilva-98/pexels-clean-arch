import 'package:dartz/dartz.dart';
import 'package:pexels_clean_arch/core/erros/failures.dart';

abstract class Usecase<Output, Input> {
  Future<Either<Failure, Output>> call({Input? param});
}
