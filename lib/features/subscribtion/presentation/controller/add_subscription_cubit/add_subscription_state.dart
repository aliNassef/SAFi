part of 'add_subscription_cubit.dart';

sealed class AddSubscriptionState extends Equatable {
  const AddSubscriptionState();

  @override
  List<Object> get props => [];
}

final class AddSubscriptionInitial extends AddSubscriptionState {}

final class AddSubscriptionLoading extends AddSubscriptionState {}

final class AddSubscriptionLoaded extends AddSubscriptionState {}

final class AddSubscriptionFailure extends AddSubscriptionState {
  final String errMessage;

  const AddSubscriptionFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
