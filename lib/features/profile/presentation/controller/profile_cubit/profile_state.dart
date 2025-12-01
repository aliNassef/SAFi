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

final class UploadProfileDataLoading extends ProfileState {}

final class UploadProfileDataSuccess extends ProfileState {
  const UploadProfileDataSuccess({required this.profile});
  final ProfileRequestModel profile;
  @override
  List<Object> get props => [profile];
}

final class UploadProfileDataError extends ProfileState {
  final String errMessage;
  const UploadProfileDataError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class PickImageSuccess extends ProfileState {
  final XFile image;
  const PickImageSuccess({required this.image});

  @override
  List<Object> get props => [image];
}
