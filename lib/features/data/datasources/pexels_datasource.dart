import 'dart:convert';

import 'package:pexels_clean_arch/core/erros/exceptions.dart';
import 'package:pexels_clean_arch/core/http/ihttp_client.dart';
import 'package:pexels_clean_arch/features/data/datasources/end_points/pexels_end_point.dart';
import 'package:pexels_clean_arch/features/data/datasources/iphotos_datasource.dart';
import 'package:pexels_clean_arch/features/data/models/photo_model.dart';

class PexelsDatasource implements IPhotosDatasource {
  final IHttpClient httpClient;

  PexelsDatasource(this.httpClient);

  @override
  Future<List<PhotoModel>> getPhotos({
    String? query,
  }) async {
    final response = await httpClient.get(
      PexelsEndPoints.url(query: query),
      headers: {
        'Authorization': PexelsEndPoints.apiKey,
      },
    );

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.data);
      final List<PhotoModel> list = [];
      decodedResponse['photos'].map((item) {
        list.add(PhotoModel(
          photographer: item['photographer'],
          photographerUrl: item['photographer_url'],
          photoUrl: item['src']['original'],
          alt: item['alt'],
        ));
      }).toList();

      return list;
    }

    throw ServerException();
  }
}
