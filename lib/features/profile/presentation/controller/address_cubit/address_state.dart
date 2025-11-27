part of 'address_cubit.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressSuccess extends AddressState {
  final Position position;

  const AddressSuccess({required this.position});

  @override
  List<Object> get props => [position];
}

final class AddressFailure extends AddressState {
  final String errorMessage;

  const AddressFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class GetUserAddress extends AddressState {
  final String address;

  const GetUserAddress({required this.address});

  @override
  List<Object> get props => [address];
}
