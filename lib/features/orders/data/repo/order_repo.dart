import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../model/orders_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, void>> createorder(OrdersModel order);
  Future<Either<Failure, List<OrdersModel>>> getOrders(String userId);
  String? getuserAddress();
}
