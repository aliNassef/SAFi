import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../translations/locale_keys.g.dart';
import '../utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

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
            onPressed: () {},
            icon: const Icon(
              Icons.account_balance_wallet,
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
