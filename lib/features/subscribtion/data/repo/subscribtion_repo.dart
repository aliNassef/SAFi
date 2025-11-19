import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/subscribtion_model.dart';

abstract class SubscribtionRepo {
  Future<Either<Failure, List<SubscribtionModel>>> getAllSubscribtions();
}
