import 'package:pexels_clean_arch/features/data/models/photo_model.dart';

abstract class IPhotosDatasource {
  Future<List<PhotoModel>> getPhotos({String? query});
}
