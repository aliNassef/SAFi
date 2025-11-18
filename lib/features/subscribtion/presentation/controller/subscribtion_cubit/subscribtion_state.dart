part of 'subscribtion_cubit.dart';

sealed class SubscribtionState extends Equatable {
  const SubscribtionState();

  @override
  List<Object> get props => [];
}

final class SubscribtionInitial extends SubscribtionState {}

final class SubscribtionLoading extends SubscribtionState {}

final class SubscribtionFailure extends SubscribtionState {
  final String errMessage;

  const SubscribtionFailure({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}

final class SubscribtionLoaded extends SubscribtionState {
  final List<SubscribtionModel> subscribtions;

  const SubscribtionLoaded({required this.subscribtions});
  @override
  List<Object> get props => [subscribtions];
}

final class UpdateSubscribtionPage extends SubscribtionState {
  final int index;

  const UpdateSubscribtionPage({required this.index});
  @override
  List<Object> get props => [index];
}
