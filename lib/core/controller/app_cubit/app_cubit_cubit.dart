import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class IternetCheckerCubit extends Cubit<bool> {
  late final StreamSubscription subscription;
  IternetCheckerCubit() : super(true) {
    subscription = InternetConnection().onStatusChange.listen((status) {
      emit(status == InternetStatus.connected);
    });
  }
  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}