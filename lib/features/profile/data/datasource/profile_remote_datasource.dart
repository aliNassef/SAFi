import 'package:safi/core/services/firebase_firestore_service.dart';
import 'package:safi/features/home/data/model/pricies_service_model.dart';

abstract class ProfileRemoteDatasource {
  Future<List<PriciesServiceModel>> getAllServicePrices();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final FirebaseStoreService _db;

  ProfileRemoteDatasourceImpl({required FirebaseStoreService db}) : _db = db;
  @override
  Future<List<PriciesServiceModel>> getAllServicePrices() async {
    final prices = await _db.getAllServicePrices();
    return prices.map((price) => PriciesServiceModel.fromJson(price)).toList();
  }
}
