part of 'get_services_cubit.dart';

sealed class GetServicesState extends Equatable {
  const GetServicesState();

  @override
  List<Object> get props => [];
}

final class GetServicesInitial extends GetServicesState {}

final class GetServicesLoading extends GetServicesState {}

final class GetServicesFailure extends GetServicesState {
  final String errMessage;

  const GetServicesFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class GetServicesSuccess extends GetServicesState {
  final List<ServiceModel> services;

  const GetServicesSuccess({required this.services});

  @override
  List<Object> get props => [services];
}

final class SelectedService extends GetServicesState {
  final String serviceId;
  final bool isSelected;

  const SelectedService({required this.isSelected, required this.serviceId});

  @override
  List<Object> get props => [isSelected, serviceId];
}

final class GetPriciesServiceSuccess extends GetServicesState {
  final PriceArgsModel data;

  const GetPriciesServiceSuccess(
    this.data,
  );

  @override
  List<Object> get props => [data];
}
