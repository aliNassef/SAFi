import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
 import '../datasource/home_remote_datasource.dart';
import '../model/pricies_service_model.dart';
import '../model/service_model.dart';
import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDatasource _datasource;

  HomeRepoImpl({required HomeRemoteDatasource datasource})
    : _datasource = datasource;
  @override
  Future<Either<Failure, List<ServiceModel>>> getAllService() async {
    try {
      final service = await _datasource.getServices();
      return right(service);
    } catch (e) {
      return left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PriciesServiceModel>>> getPrices(
    String serviceId,
  ) async {
    try {
      final pricies = await _datasource.getServicePrices(serviceId);
      return right(pricies);
    } catch (e) {
      return left(Failure(errMessage: e.toString()));
    }
  }

 
}
