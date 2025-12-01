import '../../features/home/presentation/controller/get_services_cubit/get_services_cubit.dart';

import 'di.dart';

final injector = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _setupExternal();
  _setupAuthFeature();
  _setupHomeFeature();
  _setupOrderFeature();
  _setupSubscribtionFeature();
  _setupTransactionFeature();
  _setupNotificationFeature();
  _setupProfileFeature();
  _setupLayoutFeature();
}

void _setupLayoutFeature() {
  injector.registerFactory<NavControllerCubit>(
    () => NavControllerCubit(),
  );
}

void _setupProfileFeature() {
  injector.registerFactory<ProfileCubit>(
    () => ProfileCubit(injector(), injector()),
  );
  injector.registerFactory<AddressCubit>(
    () => AddressCubit(injector()),
  );
  injector.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(
      localeDatasource: injector<ProfileLocaleDatasource>(),
      remoteDatasource: injector<ProfileRemoteDatasource>(),
    ),
  );

  injector.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(
      db: injector<FirebaseStoreService>(),
      fireStorageHelper: injector<FireStorageHelper>(),
      locationService: injector<LocationService>(),
    ),
  );

  injector.registerLazySingleton<ProfileLocaleDatasource>(
    () => ProfileLocaleDatasourceImpl(
      sharedPreferences: injector<SharedPreferences>(),
    ),
  );
}

void _setupNotificationFeature() {
  injector.registerFactory<NotificationCubit>(
    () => NotificationCubit(notificationRepo: injector()),
  );

  injector.registerLazySingleton<NotificationRepo>(
    () => NotificationRepoImpl(
      remoteDataSource: injector<NotificationsRemoteDataSource>(),
    ),
  );

  injector.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(
      service: injector<FirebaseStoreService>(),
    ),
  );
}

void _setupTransactionFeature() {
  injector.registerFactory<TranscationCubit>(
    () => TranscationCubit(injector()),
  );

  injector.registerLazySingleton<TransactionRepo>(
    () => TransactionRepoImpl(
      remoteDataSource: injector<TransactionsRemoteDataSource>(),
    ),
  );

  injector.registerLazySingleton<TransactionsRemoteDataSource>(
    () => TransactionsRemoteDataSourceImpl(
      stripeService: injector<StripeService>(),
      service: injector<FirebaseStoreService>(),
    ),
  );
}

Future<void> _setupExternal() async {
  injector.registerLazySingleton<CacheHelper>(() => CacheHelper());
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  injector.registerLazySingleton<IternetCheckerCubit>(
    () => IternetCheckerCubit(),
  );
  injector.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(injector()),
  );
  injector.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  injector.registerLazySingleton<FirebaseStoreService>(
    () => FirebaseStoreService(),
  );
  injector.registerLazySingleton<FireStorageHelper>(
    () => FireStorageHelper(),
  );
  injector.registerLazySingleton<StripeService>(
    () => StripeService.instance,
  );
  injector.registerLazySingleton<LocationService>(
    () => LocationServiceImpl(
      geolocatorWrapper: injector<GeolocatorWrapper>(),
    ),
  );
  injector.registerLazySingleton<GeolocatorWrapper>(
    () => GeolocatorImpl(),
  );
  injector.registerLazySingleton<ImagePickerHelper>(
    () => ImagePickerHelper(),
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
      db: injector<FirebaseStoreService>(),
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

void _setupOrderFeature() {
  injector.registerFactory<OrderCubit>(
    () => OrderCubit(injector<OrderRepo>()),
  );
  injector.registerLazySingleton<OrderRepo>(
    () => OrderRepoImpl(
      datasource: injector<OrderRemoteDatasource>(),
      localDatasource: injector<OrderLocalDatasource>(),
    ),
  );

  injector.registerLazySingleton<OrderLocalDatasource>(
    () => OrderLocalDatasourceImpl(preferences: injector<SharedPreferences>()),
  );
  injector.registerLazySingleton<OrderRemoteDatasource>(
    () => OrderRemoteDatasourceImpl(
      authService: injector<FirebaseAuthService>(),
      service: injector<FirebaseStoreService>(),
    ),
  );
}

void _setupSubscribtionFeature() {
  injector.registerFactory<SubscribtionCubit>(
    () => SubscribtionCubit(injector()),
  );
  injector.registerFactory<AddSubscriptionCubit>(
    () => AddSubscriptionCubit(injector()),
  );

  injector.registerLazySingleton<SubscribtionRepo>(
    () => SubscribtionRepoImpl(
      datasource: injector<SubscribtionRemoteDatasource>(),
    ),
  );

  injector.registerLazySingleton<SubscribtionRemoteDatasource>(
    () => SubscribtionRemoteDatasourceImpl(
      service: injector<FirebaseStoreService>(),
    ),
  );
}
