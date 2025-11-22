import 'package:safi/core/services/firebase_auth_service.dart';

import '../../../../core/services/firebase_firestore_service.dart';

import '../../../../core/enums/payment_method_enum.dart';
import '../model/orders_model.dart';

abstract class OrderRemoteDatasource {
  Future<void> createOrder(OrdersModel order);
  Future<List<OrdersModel>> getOrders(String userId);
}

class OrderRemoteDatasourceImpl extends OrderRemoteDatasource {
  final FirebaseStoreService _service;
  final FirebaseAuthService _authService;

  OrderRemoteDatasourceImpl({
    required FirebaseStoreService service,
    required FirebaseAuthService authService,
  }) : _service = service,
       _authService = authService;

  @override
  Future<void> createOrder(OrdersModel order) async {
    final userId = _authService.currentUser()?.uid;
    if (order.paymentMethod == PaymentMethodEnum.wallet.value) {
      final userDoc = await _service.getUser(userId!);
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        final int balance = data['walletBalance'];
        if (balance < order.total) {
          throw Exception('رصيد المحفظة غير كافي');
        }
        await _service.updateWallet(userId, balance - order.total);
      }
    }

    final subscription = await _service.getUserPackage(userId!);
    if (subscription != null && subscription.id != null) {
      await _service.useWash(
        userId: userId,
        subscriptionId: subscription.id!,
      );
    }

    return _service.createOrder(
      order: order,
    );
  }

  @override
  Future<List<OrdersModel>> getOrders(String userId) async =>
      _service.getUserOrders(userId);
}
