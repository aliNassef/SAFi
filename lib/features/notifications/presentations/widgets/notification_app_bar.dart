import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';

class NotificationAppBar extends StatelessWidget {
  const NotificationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      elevation: 3,
      leading: GestureDetector(
        onTap: () => AppNavigation.pop(context),
        child: const Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 16,
          ),
        ),
      ),
      centerTitle: true,
      leadingWidth: 30,
      automaticallyImplyLeading: false,
      title: Text(
        LocaleKeys.notifications.tr(),
        style: context.appTheme.semiBold16.copyWith(
          color: const Color(0xff3B3838).withValues(alpha: 0.85),
        ),
      ),
    );
  }
}
