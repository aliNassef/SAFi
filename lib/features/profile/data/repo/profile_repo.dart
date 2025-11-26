import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../home/data/model/pricies_service_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, List<PriciesServiceModel>>> getAllServicePrices();
}