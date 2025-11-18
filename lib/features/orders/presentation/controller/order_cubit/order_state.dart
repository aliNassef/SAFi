part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderFailure extends OrderState {
  final String errMessage;
  const OrderFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class OrderSuccess extends OrderState {}

final class GetOrderSuccess extends OrderState {
  final List<OrdersModel> orders;

  const GetOrderSuccess({required this.orders});
  @override
  List<Object> get props => [orders];
}
