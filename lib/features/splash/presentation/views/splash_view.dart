import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/controller/auth_cubit.dart';
import '../../../auth/presentation/controller/auth_state.dart';
import '../../../layout/presentation/views/layout_vieew.dart';
import '../../../../core/translations/locale_keys.g.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/nav_animation_enum.dart';
import '../../../../core/navigation/nav_args.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/theme/app_theme_extension.dart';
import '../../../onboarding/presentation/view/on_boarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const routeName = 'Splash_view';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        context.read<AuthCubit>().checkAuthState();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state) {
            case AuthFirstTime():
              _goToOnBoaeding();
              break;
            case AuthSuccess():
              _goToLayout();
              break;
            default:
              break;
          }
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.logo_image,
                width: 85.w,
                height: 85.h,
              ),
              const Gap(16),
              FadeInUp(
                duration: const Duration(seconds: 1),
                child: Text(
                  LocaleKeys.splash_title.tr(),
                  style: context.appTheme.bold40.copyWith(
                    color: AppColors.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToOnBoaeding() {
    AppNavigation.pushNamed(
      context,
      OnBoardingView.routeName,
      arguments: const NavArgs(animation: NavAnimation.fade),
    );
  }

  void _goToLayout() {
    AppNavigation.pushNamed(
      context,
      LayoutView.routeName,
      arguments: const NavArgs(animation: NavAnimation.fade),
    );
  }
}
