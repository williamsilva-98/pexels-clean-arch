import 'package:pexels_clean_arch/core/erros/exceptions.dart';
import 'package:pexels_clean_arch/features/data/datasources/iphotos_datasource.dart';
import 'package:pexels_clean_arch/features/domain/entities/photo_entity.dart';
import 'package:pexels_clean_arch/core/erros/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:pexels_clean_arch/features/domain/repositories/iphotos_repository.dart';

class PhotosRepository implements IPhotosRepository {
  final IPhotosDatasource datasource;

  PhotosRepository(this.datasource);

  @override
  Future<Either<Failure, List<PhotoEntity>>> getPhotos({String? query}) async {
    try {
      final result = await datasource.getPhotos(query: query);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
