import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/notification_model.dart';
import '../../../data/repo/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required NotificationRepo notificationRepo})
    : _notificationRepo = notificationRepo,
      super(NotificationInitial());
  final NotificationRepo _notificationRepo;

  void getNotifications(String uid) async {
    emit(NotificationLoading());
    final result = await _notificationRepo.getNotifications(uid);
    result.fold(
      (failure) => emit(NotificationError(errMessage: failure.errMessage)),
      (notifications) =>
          emit(NotificationSuccess(notifications: notifications)),
    );
  }

  void getUnReadCountNotifications(String uid) async {
    emit(NotificationUnReadCountLoading());
    final result = await _notificationRepo.getUnReadCountNotifications(uid);
    result.fold(
      (failure) {
        emit(const NotificationUnReadCountSuccess(count: 0));
      },
      (count) => emit(NotificationUnReadCountSuccess(count: count)),
    );
  }
}
