import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pexels_clean_arch/core/erros/failures.dart';
import 'package:pexels_clean_arch/features/domain/entities/photo_entity.dart';
import 'package:pexels_clean_arch/features/domain/repositories/iphotos_repository.dart';
import 'package:pexels_clean_arch/features/domain/usecases/get_photos_usecase.dart';

class MockPhotosRepository extends Mock implements IPhotosRepository {}

void main() {
  late GetPhotosUsecase usecase;
  late IPhotosRepository repository;

  setUp(() {
    repository = MockPhotosRepository();
    usecase = GetPhotosUsecase(repository);
  });

  const tPhotoEntityList = [
    PhotoEntity(
      photographer: 'Edu Carvalho',
      photographerUrl: 'https://www.pexels.com/@educarvalho',
      photoUrl:
          'https://images.pexels.com/photos/2050994/pexels-photo-2050994.jpeg',
      alt: 'Woman Standing Near Yellow-petaled Flower',
    ),
  ];

  final tFailure = ServerFailure();

  const tQuery = 'nature';

  void runSuccessMock() {
    when(() => repository.getPhotos()).thenAnswer(
      (_) async => const Right(tPhotoEntityList),
    );
  }

  void runFailureMock() {
    when(() => repository.getPhotos()).thenAnswer(
      (_) async => Left(tFailure),
    );
  }

  test(
    'should call the PhotosRepository',
    () async {
      // Arrange
      runSuccessMock();

      // Act
      await usecase.call();

      // Assert
      verify(() => repository.getPhotos()).called(1);
    },
  );

  test(
    'should call the PhotosRepository and return a List of PhotoEntity',
    () async {
      // Arrange
      runSuccessMock();

      // Act
      final result = await usecase.call();

      // Assert
      expect(result, const Right(tPhotoEntityList));
      verify(() => repository.getPhotos()).called(1);
    },
  );

  test(
    'should call the PhotosRepository with a query and return a list of PhotoEntity',
    () async {
      // Arrange
      when(() => repository.getPhotos(query: tQuery)).thenAnswer(
        (_) async => const Right(tPhotoEntityList),
      );

      // Act
      final result = await usecase.call(param: tQuery);

      // Assert
      expect(result, const Right(tPhotoEntityList));
      verify(() => repository.getPhotos(query: tQuery)).called(1);
    },
  );

  test(
    'should call the PhotosRepository and return a Failure',
    () async {
      // Arrange
      runFailureMock();

      // Act
      final result = await usecase.call();

      // Assert
      expect(result, Left(tFailure));
      verify(() => repository.getPhotos()).called(1);
    },
  );
}
