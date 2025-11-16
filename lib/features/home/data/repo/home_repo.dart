import 'package:dartz/dartz.dart';
 import '../../../../core/errors/failure.dart';
import '../model/pricies_service_model.dart';
import '../model/service_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ServiceModel>>> getAllService();
  Future<Either<Failure, List<PriciesServiceModel>>> getPrices(
    String serviceId,
  );
}
