import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/errors/failure.dart';
import '../../../home/data/model/pricies_service_model.dart';
import '../model/profile_request._model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, List<PriciesServiceModel>>> getAllServicePrices();
  Future<Either<Failure, Position>> determinePosition();
  Future<Either<Failure, void>> saveUserAddress(String address);
  Future<Either<Failure, void>> uploadProfileData(ProfileRequestModel profileRequestModel);
}