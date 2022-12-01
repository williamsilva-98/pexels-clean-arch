import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pexels_clean_arch/core/erros/failures.dart';
import 'package:pexels_clean_arch/features/domain/entities/photo_entity.dart';
import 'package:pexels_clean_arch/features/domain/usecases/get_photos_usecase.dart';
import 'package:pexels_clean_arch/features/presenter/pages/home/home_store.dart';

class MockGetPhotosUsecase extends Mock implements GetPhotosUsecase {}

void main() {
  late HomeStore store;
  late GetPhotosUsecase usecase;

  setUp(() {
    usecase = MockGetPhotosUsecase();
    store = HomeStore(usecase);
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

  test(
    'should return a PhotoEntity from the usecase',
    () async {
      // Arrange
      when(() => usecase.call()).thenAnswer(
        (_) async => const Right(tPhotoEntityList),
      );

      // Act
      await store.getPhotos();

      // Assert
      store.observer(
        onState: (state) {
          expect(state, tPhotoEntityList);
          verify(() => usecase.call()).called(1);
        },
      );
    },
  );

  test(
    'should return a Failure from the usecase when not succeed',
    () async {
      // Arrange
      when(() => usecase.call()).thenAnswer(
        (_) async => Left(ServerFailure()),
      );

      // Act
      await store.getPhotos();

      // Assert
      store.observer(
        onError: (state) {
          expect(state, ServerFailure());
          verify(() => usecase.call()).called(1);
        },
      );
    },
  );
}
