import 'package:pexels_clean_arch/core/erros/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:pexels_clean_arch/core/usecase/usecase.dart';
import 'package:pexels_clean_arch/features/domain/entities/photo_entity.dart';
import 'package:pexels_clean_arch/features/domain/repositories/iphotos_repository.dart';

class GetPhotosUsecase implements Usecase<List<PhotoEntity>, String> {
  final IPhotosRepository repository;

  GetPhotosUsecase(this.repository);

  @override
  Future<Either<Failure, List<PhotoEntity>>> call({String? param}) async {
    if (param != null && param.isEmpty) {
      return Left(EmptyParamFailure());
    }
    return await repository.getPhotos(query: param);
  }
}
