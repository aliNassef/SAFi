import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/utils/utils.dart';

import '../../../../core/translations/locale_keys.g.dart';

class HomeContentSection extends StatelessWidget {
  const HomeContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.order_and_enjoy_with_our_service.tr(),
          style: context.appTheme.semiBold20.copyWith(
            color: AppColors.black,
          ),
        ),
        const Gap(8),
        Text(
          LocaleKeys.you_can_choose_multiple_service.tr(),
          style: context.appTheme.medium20.copyWith(
            color: AppColors.primary,
          ),
        ),
        const Gap(28),
      ],
    ).withHorizontalPadding(16);
  }
}
