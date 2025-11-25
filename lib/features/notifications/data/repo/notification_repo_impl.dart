import 'package:dartz/dartz.dart';
import 'package:safi/core/errors/failure.dart';
import 'package:safi/features/notifications/data/model/notification_model.dart';
import 'package:safi/features/notifications/data/repo/notification_repo.dart';
import 'package:safi/features/notifications/data/datasource/notifications_remote_datasource.dart';

import '../../../../core/logging/app_logger.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications(
    String uid,
  ) async {
    try {
      final result = await remoteDataSource.getNotifications(uid);
      return Right(result);
    } catch (_) {
      return const Left(Failure(errMessage: 'Failed to get notifications'));
    }
  }

  @override
  Future<Either<Failure, num>> getUnReadCountNotifications(String uid) async {
    try {
      final result = await remoteDataSource.getUnReadCountNotifications(uid);
      return Right(result);
    } catch (e) {
      AppLogger.error(e.toString());
      return const Left(Failure(errMessage: 'Failed to get notifications'));
    }
  }
}
