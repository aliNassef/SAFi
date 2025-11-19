import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/subscribtion/data/models/subscribtion_model.dart';
import '../../features/home/data/model/price_args_model.dart';

import '../../features/auth/presentation/views/confirm_otp.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/home/presentation/controller/get_pricies_service_cubit/get_pricies_service_cubit.dart';
import '../../features/home/presentation/views/pricies_view.dart';
import '../../features/layout/presentation/views/layout_vieew.dart';
import '../../features/onboarding/presentation/view/on_boarding_view.dart';
import '../../features/orders/presentation/views/new_orders_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../features/subscribtion/presentation/view/package_view.dart';
import '../di/service_locator.dart';
import 'nav_animation_enum.dart';
import 'nav_args.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final navArgs = args is NavArgs ? args : const NavArgs(data: null);

    late final Widget page;
    switch (settings.name) {
      //? splash
      case SplashView.routeName:
        page = const SplashView();
        break;
      //? on boarding
      case OnBoardingView.routeName:
        page = const OnBoardingView();
        break;

      //? login
      case LoginView.routeName:
        page = const LoginView();
        break;
      //? otp
      case ConfirmOtp.routeName:
        page = const ConfirmOtp();
        break;
      //? layout
      case LayoutView.routeName:
        page = const LayoutView();
        break;
      //? Pricies
      case PriciesView.routeName:
        final args = settings.arguments as NavArgs;
        page = BlocProvider(
          create: (context) => injector<GetPriciesServiceCubit>(),
          child: PriciesView(
            serviceId: args.data as String,
          ),
        );
        break;
      //? orders
      case NewOrdersView.routeName:
        final args = settings.arguments as NavArgs;
        page = NewOrdersView(
          priceArgs: args.data as PriceArgsModel,
        );
        break;
      //? orders
      case PackageView.routeName:
        final args = settings.arguments as NavArgs;
        page = PackageView(
          subscriptionModel: args.data as SubscribtionModel,
        );
        break;
      default:
        page = const Scaffold(body: Center(child: Text('Page not found')));
    }

    return PageRouteBuilder(
      settings: settings,
      transitionDuration: navArgs.animation == NavAnimation.none
          ? Duration.zero
          : navArgs.duration,
      reverseTransitionDuration: navArgs.animation == NavAnimation.none
          ? Duration.zero
          : navArgs.duration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (navArgs.animation) {
          case NavAnimation.fade:
            return FadeTransition(opacity: animation, child: child);
          case NavAnimation.translate:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case NavAnimation.none:
            return child;
        }
      },
    );
  }
}
