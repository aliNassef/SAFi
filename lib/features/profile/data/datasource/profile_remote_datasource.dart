import 'package:geolocator/geolocator.dart';
import 'package:safi/core/services/firebase_firestore_service.dart';
import 'package:safi/features/home/data/model/pricies_service_model.dart';

import '../../../../core/services/location_service.dart';

abstract class ProfileRemoteDatasource {
  Future<List<PriciesServiceModel>> getAllServicePrices();
  Future<Position> determinePosition();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final FirebaseStoreService _db;
  final LocationService _locationService;

  ProfileRemoteDatasourceImpl({
    required FirebaseStoreService db,
    required LocationService locationService,
  }) : _db = db,
       _locationService = locationService;

  @override
  Future<List<PriciesServiceModel>> getAllServicePrices() async {
    final prices = await _db.getAllServicePrices();
    return prices.map((price) => PriciesServiceModel.fromJson(price)).toList();
  }

  @override
  Future<Position> determinePosition() async =>
      _locationService.determinePosition();
}
