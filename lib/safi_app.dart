import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/controller/internet_checker_cubit.dart';
import 'core/di/service_locator.dart';
import 'core/navigation/app_routes.dart';
import 'core/utils/app_constants.dart';
import 'core/utils/theme/app_theme.dart';
import 'core/widgets/widgets.dart';
import 'features/auth/presentation/controller/auth_cubit.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'core/widgets/no_internet_banner.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SafiApp extends StatelessWidget {
  const SafiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => injector<IternetCheckerCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: AppConstants.designSize,
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: SplashView.routeName, 
          onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          builder: (xontext, child) {
            final MediaQueryData data = MediaQuery.of(xontext);
            return MediaQuery(
              data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
              child: BlocBuilder<IternetCheckerCubit, bool>(
                builder: (context, isConnected) {
                  return Stack(
                    children: [
                      if (child != null)
                        IgnorePointer(
                          ignoring: !isConnected,
                          child: child,
                        ),

                      if (!isConnected)
                        const Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: SafeArea(
                            child: Material(
                              type: MaterialType.transparency,
                              child: NoInternetBanner(),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
