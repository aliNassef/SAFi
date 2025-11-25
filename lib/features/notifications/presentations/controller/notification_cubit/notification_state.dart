part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}
final class NotificationUnReadCountLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  const NotificationSuccess({required this.notifications});

  @override
  List<Object> get props => [notifications];
}

final class NotificationError extends NotificationState {
  final String errMessage;
  const NotificationError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class NotificationUnReadCountSuccess extends NotificationState {
  final num count;
  const NotificationUnReadCountSuccess({required this.count});

  @override
  List<Object> get props => [count];
}

