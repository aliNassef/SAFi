 
import '../../../../core/services/firebase_firestore_service.dart';
import '../model/pricies_service_model.dart';
import '../model/service_model.dart';

abstract class HomeRemoteDatasource {
  Future<List<ServiceModel>> getServices();
  Future<List<PriciesServiceModel>> getServicePrices(String serviceId);
 
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final FirebaseStoreService _service;

  HomeRemoteDatasourceImpl({required FirebaseStoreService service})
    : _service = service;

  @override
  Future<List<ServiceModel>> getServices() async {
    final response = await _service.getAllServices();

    List<ServiceModel> services = response.docs
        .map((service) => ServiceModel.fromMap(service.data()))
        .toList();

    return services;
  }

  @override
  Future<List<PriciesServiceModel>> getServicePrices(String serviceId) async {
    final response = await _service.getPrices(serviceId);
    final List<PriciesServiceModel> prices = response
        .map((item) => PriciesServiceModel.fromJson(item))
        .toList();

    return prices;
  }

 
}
