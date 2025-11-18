import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/orders_model.dart';
import '../../../data/repo/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._orderRepo) : super(OrderInitial());
  final OrderRepo _orderRepo;

  void createOrder(OrdersModel order) async {
    emit(OrderLoading());

    final addOrderOrfailure = await _orderRepo.createorder(order);

    addOrderOrfailure.fold(
      (failure) => emit(OrderFailure(errMessage: failure.errMessage)),
      (_) => emit(OrderSuccess()),
    );
  }

  void getOrders(String userId) async {
    emit(OrderLoading());

    final orderOrfailure = await _orderRepo.getOrders(userId);

    orderOrfailure.fold(
      (failure) => emit(OrderFailure(errMessage: failure.errMessage)),
      (orders) => emit(GetOrderSuccess(orders: orders)),
    );
  }
}
