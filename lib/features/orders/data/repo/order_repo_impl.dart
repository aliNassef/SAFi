import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../datasource/order_remote_datasource.dart';

import '../model/orders_model.dart';

import 'order_repo.dart';

class OrderRepoImpl extends OrderRepo {
  final OrderRemoteDatasource _datasource;

  OrderRepoImpl({required OrderRemoteDatasource datasource})
    : _datasource = datasource;
  @override
  Future<Either<Failure, void>> createorder(OrdersModel order) async {
    try {
      await _datasource.createorder(order);
      return right(null);
    } catch (e) {
      return left(Failure(errMessage: e.toString()));
    }
  }
}
