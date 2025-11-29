import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import '../../env/env.dart';
import '../../firebase_options.dart';
import '../di/service_locator.dart';
import '../helpers/cache_helper.dart';
import '../logging/app_logger.dart';
import '../logging/custom_bloc_observer.dart';
import '../services/fcm_service.dart';
import '../services/local_notiffication_service.dart';
import 'app_color.dart';

class AppInitializer {
  static Future<void> init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    Bloc.observer = CustomBlocObserver();
    await CacheHelper.init();
    await setupServiceLocator();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
    await LocalNotificationService.instance.init();
    await LocalNotificationService.instance.requestPermissions();
    await FcmService.instance.init();
    await ScreenUtil.ensureScreenSize();

    Stripe.publishableKey = Env.stripePublishKey;
    await Stripe.instance.applySettings();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary, // draw behind status bar
        statusBarIconBrightness: Brightness.light, // ANDROID
        statusBarBrightness: Brightness.light, // iOS (opposite of icons)
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
    );

    AppLogger.info('SAFI APP Started ✅');
  }
}
