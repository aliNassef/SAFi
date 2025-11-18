import 'package:dartz/dartz.dart';
import 'package:safi/core/errors/failure.dart';
import 'package:safi/features/subscribtion/data/models/subscribtion_model.dart';

abstract class SubscribtionRepo {
  Future<Either<Failure, List<SubscribtionModel>>> getAllSubscribtions();
}
