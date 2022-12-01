import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pexels_clean_arch/core/erros/exceptions.dart';
import 'package:pexels_clean_arch/core/erros/failures.dart';
import 'package:pexels_clean_arch/features/data/datasources/iphotos_datasource.dart';
import 'package:pexels_clean_arch/features/data/models/photo_model.dart';
import 'package:pexels_clean_arch/features/data/repositories/photos_repository.dart';
import 'package:pexels_clean_arch/features/domain/repositories/iphotos_repository.dart';

class MockPhotosDatasource extends Mock implements IPhotosDatasource {}

void main() {
  late PhotosRepository repository;
  late IPhotosDatasource datasource;

  setUp(() {
    datasource = MockPhotosDatasource();
    repository = PhotosRepository(datasource);
  });

  const tPhotoModelList = [
    PhotoModel(
      photographer: 'Edu Carvalho',
      photographerUrl: 'https://www.pexels.com/@educarvalho',
      photoUrl:
          'https://images.pexels.com/photos/2050994/pexels-photo-2050994.jpeg',
      alt: 'Woman Standing Near Yellow-petaled Flower',
    ),
  ];

  void runSuccessMock() {
    when(() => datasource.getPhotos()).thenAnswer(
      (_) async => tPhotoModelList,
    );
  }

  test('PhotosRepository should implements the IPhotosRepository', () {
    // Assert
    expect(repository, isA<IPhotosRepository>());
  });

  test(
      'when the repository gets called it should also call the PhotosDatasource inside',
      () async {
    // Arrange
    runSuccessMock();

    // Act
    await repository.getPhotos();

    // Assert
    verify(() => datasource.getPhotos()).called(1);
  });

  test('when the repository gets called it should returns a List of PhotoModel',
      () async {
    // Arrange
    runSuccessMock();

    // Act
    final result = await repository.getPhotos();

    // Assert
    expect(result, const Right(tPhotoModelList));
    verify(() => datasource.getPhotos()).called(1);
  });

  test(
      'should return a server failure when calls to the datasource is unsucessful',
      () async {
    // Arrange
    when(() => datasource.getPhotos()).thenThrow(ServerException());

    // Act
    final result = await repository.getPhotos();

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getPhotos()).called(1);
  });
}
