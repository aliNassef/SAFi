import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:safi/features/notifications/data/datasource/notifications_remote_datasource.dart';
import 'package:safi/features/notifications/presentations/controller/notification_cubit/notification_cubit.dart';
import 'package:safi/features/transactions/data/datasource/transactions_remote_datasource.dart';
import 'package:safi/features/transactions/presentations/cubit/transcation_cubit.dart';
import '../../features/notifications/data/repo/notification_repo.dart';
import '../../features/notifications/data/repo/notification_repo_impl.dart';
import '../../features/orders/data/datasource/order_remote_datasource.dart';
import '../../features/orders/data/repo/order_repo.dart';
import '../../features/orders/data/repo/order_repo_impl.dart';
import '../../features/orders/presentation/controller/order_cubit/order_cubit.dart';
import '../../features/subscribtion/data/datasource/subscribtion_remote_datasource.dart';
import '../../features/subscribtion/data/repo/subscribtion_repo.dart';
import '../../features/subscribtion/presentation/controller/add_subscription_cubit/add_subscription_cubit.dart';
import '../../features/subscribtion/presentation/controller/subscribtion_cubit/subscribtion_cubit.dart';

import '../../features/auth/data/datasource/auth_remote_datasource.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/presentation/controller/auth_cubit.dart';
import '../../features/home/data/datasource/home_remote_datasource.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/presentation/controller/get_pricies_service_cubit/get_pricies_service_cubit.dart';
import '../../features/home/presentation/controller/get_services_cubit/get_services_cubit.dart';
import '../../features/subscribtion/data/repo/subscribtion_repo_impl.dart';
import '../../features/transactions/data/repo/transaction_repo.dart';
import '../../features/transactions/data/repo/transaction_repo_impl.dart';
import '../helpers/cache_helper.dart';
import '../services/firebase_auth_service.dart';
import '../services/firebase_firestore_service.dart';

final injector = GetIt.instance;

Future<void> setupServiceLocator() async {
  _setupExternal();
  _setupAuthFeature();
  _setupHomeFeature();
  _setupOrderFeature();
  _setupSubscribtionFeature();
  _setupTransactionFeature();
  _setupNotificationFeature();
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
      service: injector<FirebaseStoreService>(),
    ),
  );
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
    () => OrderRepoImpl(datasource: injector<OrderRemoteDatasource>()),
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
