import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pexels_clean_arch/core/erros/exceptions.dart';
import 'package:pexels_clean_arch/core/http/ihttp_client.dart';
import 'package:pexels_clean_arch/features/data/datasources/end_points/pexels_end_point.dart';
import 'package:pexels_clean_arch/features/data/datasources/iphotos_datasource.dart';
import 'package:pexels_clean_arch/features/data/datasources/pexels_datasource.dart';
import 'package:pexels_clean_arch/features/data/models/photo_model.dart';
import '../../../mocks/photos_list_mock.dart';

class MockHttpClient extends Mock implements IHttpClient {}

void main() {
  late IPhotosDatasource datasource;
  late IHttpClient httpClient;

  setUp(() {
    httpClient = MockHttpClient();
    datasource = PexelsDatasource(httpClient);
  });

  const String tUrl =
      'https://api.pexels.com/v1/search?query=people&per_page=50';

  const tPhotoModelList = [
    PhotoModel(
      photographer: 'Edu Carvalho',
      photographerUrl: 'https://www.pexels.com/@educarvalho',
      photoUrl:
          'https://images.pexels.com/photos/2050994/pexels-photo-2050994.jpeg',
      alt: 'Woman Standing Near Yellow-petaled Flower',
    ),
  ];

  final tHeaders = {
    'Authorization': PexelsEndPoints.apiKey,
  };

  test(
    'PexelsDatasource should implements IPhotosDatasource',
    () {
      // Assert
      expect(datasource, isA<PexelsDatasource>());
    },
  );

  test(
    'should call the get method with the correct url when calls the datasource',
    () async {
      // Arrange
      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => HttpResponse(photosListMock, 200),
      );

      // Act
      datasource.getPhotos(query: 'people');

      // Assert
      verify(() => httpClient.get(tUrl, headers: tHeaders)).called(1);
    },
  );

  test(
    'should returns a list of PhotoModel when calls the datasource',
    () async {
      // Arrange
      when(() => httpClient.get(tUrl, headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => HttpResponse(photosListMock, 200),
      );

      // Act
      final result = await datasource.getPhotos(query: 'people');

      // Assert
      expect(result, tPhotoModelList);
      verify(() => httpClient.get(tUrl, headers: tHeaders)).called(1);
    },
  );

  test(
    'should throws a ServerException when calls the datasource',
    () async {
      // Arrange
      when(() => httpClient.get(tUrl, headers: any(named: 'headers')))
          .thenAnswer(
        (_) async => HttpResponse('opps', 400),
      );

      // Act
      final result = datasource.getPhotos(query: 'people');

      // Assert
      expect(result, throwsA(ServerException()));
    },
  );
}
