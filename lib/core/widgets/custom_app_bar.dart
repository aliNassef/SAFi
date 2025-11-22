import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safi/features/transactions/presentations/view/wallet_balance_view.dart';

import '../navigation/app_navigation.dart';
import '../translations/locale_keys.g.dart';
import '../utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}
