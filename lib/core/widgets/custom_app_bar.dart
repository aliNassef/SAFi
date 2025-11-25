import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safi/core/di/service_locator.dart';
import 'package:safi/core/navigation/nav_animation_enum.dart';
import 'package:safi/core/navigation/nav_args.dart';
import 'package:safi/features/auth/presentation/controller/auth_cubit.dart';
import 'package:safi/features/transactions/presentations/view/wallet_balance_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../features/notifications/presentations/controller/notification_cubit/notification_cubit.dart';
import '../../features/notifications/presentations/view/notifications_view.dart';
import '../navigation/app_navigation.dart';
import '../translations/locale_keys.g.dart';
import '../utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final uid = injector<AuthCubit>().getCurrentUser()!.uid;
    return AppBar(
      elevation: 2,
      leading: const SizedBox.shrink(),
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Column(
            children: [
              Image.asset(
                AppAssets.logo_image,
                width: 50,
                height: 30,
              ),
            ],
          ),
          const Spacer(),

          Text(
            LocaleKeys.app_name.tr(),
            style: context.appTheme.bold20.copyWith(
              color: AppColors.secondary,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              AppNavigation.pushNamed(
                context,
                WalletBalanceView.routeName,
                useAppRoute: true,
              );
            },
            icon: const Icon(
              CupertinoIcons.creditcard_fill,
              color: AppColors.deepGrey,
            ),
          ),
          BlocProvider(
            create: (context) =>
                injector<NotificationCubit>()..getUnReadCountNotifications(uid),
            child: Builder(
              builder: (context) {
                return BlocBuilder<NotificationCubit, NotificationState>(
                  buildWhen: (previous, current) =>
                      current is NotificationUnReadCountSuccess ||
                      current is NotificationError ||
                      current is NotificationUnReadCountLoading,
                  builder: (context, state) {
                    if (state is NotificationUnReadCountSuccess) {
                      if (state.count == 0) {
                        return IconButton(
                          onPressed: () {
                            AppNavigation.pushNamed(
                              context,
                              NotificationsView.routeName,
                              useAppRoute: true,
                              arguments: NavArgs(
                                animation: NavAnimation.fade,
                                data: context.read<NotificationCubit>(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.notifications),
                        );
                      }
                      return IconButton(
                        onPressed: () {
                          AppNavigation.pushNamed(
                            context,
                            NotificationsView.routeName,
                            useAppRoute: true,
                            arguments: NavArgs(
                              animation: NavAnimation.fade,
                              data: context.read<NotificationCubit>(),
                            ),
                          );
                        },
                        icon: Badge.count(
                          backgroundColor: AppColors.primary,
                          count: state.count.toInt(),
                          child: const Icon(Icons.notifications),
                        ),
                      );
                    }

                    if (state is NotificationError) {
                      return const Icon(Icons.notifications);
                    }

                    if (state is NotificationUnReadCountLoading) {
                      return const Skeletonizer(
                        enabled: true,
                        child: Icon(Icons.notifications),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
