import 'package:dartz/dartz.dart';
import 'package:pexels_clean_arch/core/erros/failures.dart';
import 'package:pexels_clean_arch/features/domain/entities/photo_entity.dart';

abstract class IPhotosRepository {
  Future<Either<Failure, List<PhotoEntity>>> getPhotos({String? query});
}
