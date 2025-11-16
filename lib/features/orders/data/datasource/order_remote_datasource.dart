import '../../../../core/services/firebase_firestore_service.dart';
import '../model/orders_model.dart';

abstract class OrderRemoteDatasource {
  Future<void> createorder(OrdersModel order);
}

class OrderRemoteDatasourceImpl extends OrderRemoteDatasource {
  final FirebaseStoreService _service;

  OrderRemoteDatasourceImpl({required FirebaseStoreService service})
    : _service = service;

  @override
  Future<void> createorder(OrdersModel order) async => _service.createOrder(
    order: order,
  );
}
