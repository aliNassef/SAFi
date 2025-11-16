part of 'get_pricies_service_cubit.dart';

sealed class GetPriciesServiceState extends Equatable {
  const GetPriciesServiceState();

  @override
  List<Object> get props => [];
}

final class GetPriciesServiceInitial extends GetPriciesServiceState {}

final class GetPriciesServiceLoading extends GetPriciesServiceState {}

final class GetPriciesServiceSuccess extends GetPriciesServiceState {
  final List<PriciesServiceModel> data;
  final num totalPrice;
  final String serviceId;

  const GetPriciesServiceSuccess(this.data, this.totalPrice, this.serviceId);

  @override
  List<Object> get props => [data, totalPrice, serviceId];
}

final class GetPriciesServiceFailure extends GetPriciesServiceState {
  final String errorMessage;

  const GetPriciesServiceFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
