import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safi/core/errors/failure.dart';
import 'package:safi/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:safi/features/profile/data/model/profile_request._model.dart';
import 'package:safi/features/profile/data/repo/profile_repo.dart';

import '../../../home/data/model/pricies_service_model.dart';
import '../datasource/profile_locale_datasource.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDatasource remoteDatasource;
  final ProfileLocaleDatasource localeDatasource;
  ProfileRepoImpl({
    required this.remoteDatasource,
    required this.localeDatasource,
  });

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

  @override
  Future<Either<Failure, void>> saveUserAddress(String address) async {
    try {
      await localeDatasource.saveUserAddress(address);
      return right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> uploadProfileData(ProfileRequestModel profileRequestModel)async {
    try {
      await remoteDatasource.uploadProfileData(profileRequestModel);
      return right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
