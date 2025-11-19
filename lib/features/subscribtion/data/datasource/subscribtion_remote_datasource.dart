import '../../../../core/services/firebase_firestore_service.dart';
import '../models/subscribtion_model.dart';

abstract class SubscribtionRemoteDatasource {
  Future<List<SubscribtionModel>> getAllSubscribtions();
  Future<SubscribtionModel?> getUserPackage(String userId);
  Future<void> addSubscripe({
    required String userId,
    required SubscribtionModel subscripe,
  });
}

class SubscribtionRemoteDatasourceImpl extends SubscribtionRemoteDatasource {
  final FirebaseStoreService _service;

  SubscribtionRemoteDatasourceImpl({required FirebaseStoreService service})
    : _service = service;
  @override
  Future<List<SubscribtionModel>> getAllSubscribtions() async {
    final response = await _service.getAllSubscriptions();
    final subscribtions = response.docs
        .map(
          (sub) =>
              SubscribtionModel.fromJson(sub.data() as Map<String, dynamic>),
        )
        .toList();

    return subscribtions;
  }

  @override
  Future<void> addSubscripe({
    required String userId,
    required SubscribtionModel subscripe,
  }) async => _service.subscribeUser(
    userId: userId,
    name: subscripe.name,
    advantages: subscripe.advantages,
    price: subscripe.price.toInt(),
    washesIncluded: subscripe.washesInclude!,
  );

  @override
  Future<SubscribtionModel?> getUserPackage(String userId) async =>
      _service.getUserPackage(userId);
}
