import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasource/auth_remote_datasource.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/presentation/controller/auth_cubit.dart';
import '../../features/home/data/datasource/home_remote_datasource.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/presentation/controller/get_pricies_service_cubit/get_pricies_service_cubit.dart';
import '../../features/home/presentation/controller/get_services_cubit/get_services_cubit.dart';
import '../helpers/cache_helper.dart';
import '../services/firebase_auth_service.dart';
import '../services/firebase_firestore_service.dart';

final injector = GetIt.instance;

Future<void> setupServiceLocator() async {
  _setupExternal();
  _setupAuthFeature();
  _setupHomeFeature();
}

void _setupExternal() {
  injector.registerLazySingleton<CacheHelper>(() => CacheHelper());
  injector.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(injector()),
  );
  injector.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  injector.registerLazySingleton<FirebaseStoreService>(
    () => FirebaseStoreService(),
  );
}

void _setupAuthFeature() {
  injector.registerFactory<AuthCubit>(
    () => AuthCubit(
      injector<AuthRepo>(),
    ),
  );

  injector.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      authRemoteDatasource: injector<AuthRemoteDatasource>(),
    ),
  );
  injector.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      authService: injector<FirebaseAuthService>(),
    ),
  );
}

void _setupHomeFeature() {
  injector.registerFactory<GetServicesCubit>(
    () => GetServicesCubit(injector<HomeRepo>()),
  );
  injector.registerFactory<GetPriciesServiceCubit>(
    () => GetPriciesServiceCubit(injector<HomeRepo>()),
  );
  injector.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(datasource: injector<HomeRemoteDatasource>()),
  );
  injector.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(service: injector<FirebaseStoreService>()),
  );
}
