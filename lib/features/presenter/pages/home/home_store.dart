import 'package:flutter_triple/flutter_triple.dart';
import 'package:pexels_clean_arch/core/erros/failures.dart';
import 'package:pexels_clean_arch/features/domain/entities/photo_entity.dart';
import 'package:pexels_clean_arch/features/domain/usecases/get_photos_usecase.dart';

class HomeStore extends NotifierStore<Failure, List<PhotoEntity>> {
  final GetPhotosUsecase usecase;

  HomeStore(this.usecase) : super([]);

  Future<void> getPhotos({String? query}) async {
    setLoading(true);

    final result = await usecase.call(param: query);

    result.fold((l) => setError(l), (r) => update(r));

    setLoading(false);
  }
}
