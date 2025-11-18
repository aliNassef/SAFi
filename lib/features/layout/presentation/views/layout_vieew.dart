import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../orders/presentation/views/orders_view.dart';
import '../../../subscribtion/presentation/view/subscribtion_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});
  static const routeName = 'LayoutVieew';

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  double activeIconSize = 30;
  double inactiveIconSize = 25;
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: const HomeView(),
          item: ItemConfig(
            icon: SizedBox.square(
              dimension: activeIconSize,
              child: SvgPicture.asset(
                AppAssets.home_active_icon,
              ),
            ),
            inactiveIcon: SizedBox.square(
              dimension: inactiveIconSize,
              child: SvgPicture.asset(
                AppAssets.home_in_active_icon,
              ),
            ),
            title: LocaleKeys.home.tr(),
            textStyle: context.appTheme.bold16.copyWith(
              color: const Color(0xff353030),
            ),
          ),
        ),
        PersistentTabConfig(
          screen: const OrdersView(),
          item: ItemConfig(
            icon: SizedBox.square(
              dimension: activeIconSize,
              child: SvgPicture.asset(
                AppAssets.orders_active_icon,
              ),
            ),
            inactiveIcon: SizedBox.square(
              dimension: inactiveIconSize,
              child: SvgPicture.asset(
                AppAssets.orders_in_active_icon,
              ),
            ),
            title: LocaleKeys.my_orders.tr(),
            textStyle: context.appTheme.bold16.copyWith(
              color: const Color(0xff353030),
            ),
          ),
        ),
        PersistentTabConfig(
          screen: const SubscribtionView(),
          item: ItemConfig(
            icon: SizedBox.square(
              dimension: activeIconSize,
              child: SvgPicture.asset(
                AppAssets.subescribes_active_icon,
              ),
            ),
            inactiveIcon: SizedBox.square(
              dimension: inactiveIconSize,
              child: SvgPicture.asset(
                AppAssets.subescribes_in_active_icon,
              ),
            ),
            title: LocaleKeys.packages.tr(),
            textStyle: context.appTheme.bold16.copyWith(
              color: const Color(0xff353030),
            ),
          ),
        ),
        PersistentTabConfig(
          screen: Container(),
          item: ItemConfig(
            icon: SizedBox.square(
              dimension: activeIconSize,
              child: SvgPicture.asset(
                AppAssets.profile_active_icon,
              ),
            ),
            inactiveIcon: SizedBox.square(
              dimension: inactiveIconSize,
              child: SvgPicture.asset(
                AppAssets.profile_in_active_icon,
              ),
            ),
            title: LocaleKeys.my_account.tr(),
            textStyle: context.appTheme.bold16.copyWith(
              color: const Color(0xff353030),
            ),
          ),
        ),
      ],

      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        height: kBottomNavigationBarHeight + 20,
        navBarDecoration: NavBarDecoration(
          padding: const EdgeInsets.only(top: 10),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.17),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 7,
              spreadRadius: 1,
              color: AppColors.black.withValues(alpha: 0.25),
            ),
          ],
        ),
      ),
    );
  }
}
