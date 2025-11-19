import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/utils/app_initializer.dart';

import 'safi_app.dart';

void main() async {
  await AppInitializer.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      EasyLocalization(
        path: 'assets/translations',
        startLocale: const Locale('ar'),
        supportedLocales: [const Locale('ar'), const Locale('en')],
        child: const SafiApp(),
      ),
    ),
  );
}
