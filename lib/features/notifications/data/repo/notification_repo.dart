import 'package:dartz/dartz.dart';
import 'package:safi/features/notifications/data/model/notification_model.dart';

import '../../../../core/errors/failure.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications(String uid);
  Future<Either<Failure, num>> getUnReadCountNotifications(String uid);
}