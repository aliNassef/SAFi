import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safi/core/errors/failure.dart';
import 'package:safi/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:safi/features/profile/data/repo/profile_repo.dart';

import '../../../home/data/model/pricies_service_model.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepoImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<PriciesServiceModel>>>
  getAllServicePrices() async {
    try {
      final prices = await remoteDatasource.getAllServicePrices();
      return Right(prices);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Position>> determinePosition() async {
    try {
      final position = await remoteDatasource.determinePosition();
      return Right(position);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
