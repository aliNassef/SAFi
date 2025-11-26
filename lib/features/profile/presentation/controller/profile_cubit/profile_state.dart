part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class GetAllServicePricesLoading extends ProfileState {}

final class GetAllServicePricesSuccess extends ProfileState {
  final List<PriciesServiceModel> prices;
  const GetAllServicePricesSuccess({required this.prices});

  @override
  List<Object> get props => [prices];
}

final class GetAllServicePricesError extends ProfileState {
  final String errMessage;
  const GetAllServicePricesError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
