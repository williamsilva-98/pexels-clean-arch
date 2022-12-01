import 'package:get_it/get_it.dart';
import 'package:pexels_clean_arch/core/http/http_client.dart';
import 'package:pexels_clean_arch/features/data/datasources/pexels_datasource.dart';
import 'package:pexels_clean_arch/features/data/repositories/photos_repository.dart';
import 'package:pexels_clean_arch/features/domain/usecases/get_photos_usecase.dart';
import 'package:pexels_clean_arch/features/presenter/pages/home/home_store.dart';

final getIt = GetIt.instance;

void setUpHomeBinding() {
  getIt.registerLazySingleton<HomeStore>(
    () => HomeStore(getIt.get<GetPhotosUsecase>()),
  );

  getIt.registerLazySingleton<GetPhotosUsecase>(
    () => GetPhotosUsecase(getIt.get<PhotosRepository>()),
  );

  getIt.registerLazySingleton<PhotosRepository>(
    () => PhotosRepository(getIt.get<PexelsDatasource>()),
  );

  getIt.registerLazySingleton<PexelsDatasource>(
    () => PexelsDatasource(getIt.get<HttpClient>()),
  );

  getIt.registerLazySingleton<HttpClient>(
    () => HttpClient(),
  );
}
