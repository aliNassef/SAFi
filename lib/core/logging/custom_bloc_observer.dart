import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_logger.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    AppLogger.debug('${bloc.runtimeType} $change', tag: 'BlocChange');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.error(
      '${bloc.runtimeType} $error',
      error: error,
      stackTrace: stackTrace,
      tag: 'BlocError',
    );
  }
}
