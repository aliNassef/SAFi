import 'package:geolocator/geolocator.dart';
import 'package:safi/core/services/fire_storage_service.dart';
import 'package:safi/core/services/firebase_firestore_service.dart';
import 'package:safi/features/home/data/model/pricies_service_model.dart';

import '../../../../core/services/location_service.dart';
import '../model/profile_request._model.dart';

abstract class ProfileRemoteDatasource {
  Future<List<PriciesServiceModel>> getAllServicePrices();
  Future<Position> determinePosition();
  Future<void> uploadProfileData(ProfileRequestModel profileRequestModel);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final FirebaseStoreService _db;
  final LocationService _locationService;
  final FireStorageHelper _fireStorageHelper;

  ProfileRemoteDatasourceImpl({
    required FirebaseStoreService db,
    required LocationService locationService,
    required FireStorageHelper fireStorageHelper,
  }) : _db = db,
       _locationService = locationService,
       _fireStorageHelper = fireStorageHelper;

  @override
  Future<List<PriciesServiceModel>> getAllServicePrices() async {
    final prices = await _db.getAllServicePrices();
    return prices.map((price) => PriciesServiceModel.fromJson(price)).toList();
  }

  @override
  Future<Position> determinePosition() async =>
      _locationService.determinePosition();

  @override
  Future<void> uploadProfileData(
    ProfileRequestModel profileRequestModel,
  ) async {
    String? imageUrl;
    if (profileRequestModel.image != null) {
      imageUrl = await _fireStorageHelper.uploadFile(
        profileRequestModel.image!,
        'profile/${profileRequestModel.name}',
      );
    }
    await _db.updateProfileData(
      profileRequestModel.userId,
      profileRequestModel.copyWith(imageUrl: imageUrl),
    );
  }
}
