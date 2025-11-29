import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'core/utils/app_initializer.dart';
import 'safi_app.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      await AppInitializer.init();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      runApp(
        EasyLocalization(
          path: 'assets/translations',
          startLocale: const Locale('ar'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          child: const SafiApp(),
        ),
      );
    },
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}
