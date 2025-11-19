import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/subscribtion_model.dart';

abstract class SubscribtionRepo {
  Future<Either<Failure, List<SubscribtionModel>>> getAllSubscribtions();
  Future<Either<Failure, SubscribtionModel?>> getUserPackage(String userId);
  Future<Either<Failure, void>> addSubscripe({
    required String userId,
    required SubscribtionModel subscripe,
  });
}
