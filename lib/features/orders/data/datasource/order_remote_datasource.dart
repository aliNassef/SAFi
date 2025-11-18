import '../../../../core/services/firebase_firestore_service.dart';
import '../model/orders_model.dart';

abstract class OrderRemoteDatasource {
  Future<void> createOrder(OrdersModel order);
  Future<List<OrdersModel>> getOrders(String userId);
}

class OrderRemoteDatasourceImpl extends OrderRemoteDatasource {
  final FirebaseStoreService _service;

  OrderRemoteDatasourceImpl({required FirebaseStoreService service})
    : _service = service;

  @override
  Future<void> createOrder(OrdersModel order) async => _service.createOrder(
    order: order,
  );

  @override
  Future<List<OrdersModel>> getOrders(String userId) async =>
      _service.getUserOrders(userId);
}
