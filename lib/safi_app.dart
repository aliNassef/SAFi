import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'core/utils/app_constants.dart';
import 'features/auth/presentation/controller/auth_cubit.dart';

import 'core/navigation/app_routes.dart';
import 'core/utils/theme/app_theme.dart';
import 'core/widgets/widgets.dart';
import 'features/splash/presentation/views/splash_view.dart';

class SafiApp extends StatelessWidget {
  const SafiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<AuthCubit>(),
      child: ScreenUtilInit(
        designSize: AppConstants.designSize,
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: SplashView.routeName,
          onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
        ),
      ),
    );
  }
}
