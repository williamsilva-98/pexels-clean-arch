import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pexels_clean_arch/features/data/models/photo_model.dart';
import 'package:pexels_clean_arch/features/domain/entities/photo_entity.dart';

import '../../../mocks/photo_mock.dart';

void main() {
  const PhotoModel tPhotoModel = PhotoModel(
    photographer: 'Edu Carvalho',
    photographerUrl: 'https://www.pexels.com/@educarvalho',
    photoUrl:
        'https://images.pexels.com/photos/2050994/pexels-photo-2050994.jpeg',
    alt: 'Woman Standing Near Yellow-petaled Flower',
  );

  test('PhotoModel should be of type PhotoEntity', () {
    // Assert
    expect(tPhotoModel, isA<PhotoEntity>());
  });

  test('should return a PhotoModel from a map', () {
    // Arrange
    final Map<String, dynamic> map = jsonDecode(photoMock);

    // Act
    final result = PhotoModel.fromMap(map);

    // Assert
    expect(result, tPhotoModel);
  });

  test('should encode a PhotoModel to a map', () {
    // Arrange
    final expectedMap = {
      'photographer': 'Edu Carvalho',
      'photographer_url': 'https://www.pexels.com/@educarvalho',
      'original':
          'https://images.pexels.com/photos/2050994/pexels-photo-2050994.jpeg',
      'alt': 'Woman Standing Near Yellow-petaled Flower'
    };

    // Act
    final result = tPhotoModel.toMap();

    // Assert
    expect(result, expectedMap);
  });

  test('should return a PhotoModel from a json string', () {
    // Act
    final result = PhotoModel.fromJson(photoMock);

    // Assert
    expect(result, tPhotoModel);
  });

  test('should return a encoded string from a PhotoModel', () {
    // Arrange
    const expectedString =
        '''{"photographer":"Edu Carvalho","photographer_url":"https://www.pexels.com/@educarvalho","original":"https://images.pexels.com/photos/2050994/pexels-photo-2050994.jpeg","alt":"Woman Standing Near Yellow-petaled Flower"}''';

    // Act
    final result = tPhotoModel.toJson();

    // Assert
    expect(result, expectedString);
  });
}
