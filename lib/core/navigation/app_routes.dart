import 'navigation.dart';
import 'nav_animation_enum.dart';
import 'nav_args.dart';
import 'package:flutter/material.dart';

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
      //? wallet balance
      case WalletBalanceView.routeName:
        page = const WalletBalanceView();
        break;

      //? package subcriped
      case PackageSubscripedView.routeName:
        page = const PackageSubscripedView();
        break;

      //? all transaction
      case AllTransactionView.routeName:
        final args = settings.arguments as NavArgs;
        page = AllTransactionView(
          cubit: args.data as TranscationCubit,
        );
        break;
      //? notifications
      case NotificationsView.routeName:
        final args = settings.arguments as NavArgs;
        page = NotificationsView(
          cubit: args.data as NotificationCubit,
        );
        break;
      //? paypal
      case PaypalView.routeName:
        final args = settings.arguments as NavArgs;
        page = PaypalView(
          clientId: Env.paypalClientId,
          secretKey: Env.paypalSecretKey,
          amount: args.data as double,
        );
        break;
      //? all services prices
      case AllServiciesPriciesView.routeName:
        final args = settings.arguments as NavArgs;
        page = AllServiciesPriciesView(
          cubit: args.data as ProfileCubit,
        );
        break;
      //? address
      case AddressView.routeName:
        page = const AddressView();
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
