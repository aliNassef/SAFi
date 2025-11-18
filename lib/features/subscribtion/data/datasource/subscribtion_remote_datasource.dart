import 'package:safi/core/services/firebase_firestore_service.dart';
import 'package:safi/features/subscribtion/data/models/subscribtion_model.dart';

abstract class SubscribtionRemoteDatasource {
  Future<List<SubscribtionModel>> getAllSubscribtions();
}

class SubscribtionRemoteDatasourceImpl extends SubscribtionRemoteDatasource {
  final FirebaseStoreService _service;

  SubscribtionRemoteDatasourceImpl({required FirebaseStoreService service})
    : _service = service;
  @override
  Future<List<SubscribtionModel>> getAllSubscribtions() async {
    final response = await _service.getAllServices();
    final subscribtions = response.docs
        .map(
          (sub) =>
              SubscribtionModel.fromJson(sub.data() as Map<String, dynamic>),
        )
        .toList();

    return subscribtions;
  }
}
