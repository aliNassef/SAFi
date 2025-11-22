import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/extensions/mediaquery_size.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/app_color.dart';
import 'package:safi/core/utils/app_constants.dart';
import 'package:safi/core/utils/theme/app_theme_extension.dart';
import 'package:safi/core/widgets/default_app_button.dart';
import 'package:safi/features/transactions/presentations/widgets/tranaction_list_bloc_builder.dart';

class WalletBalanceViewBody extends StatelessWidget {
  const WalletBalanceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(16),
        Container(
          padding: const EdgeInsets.all(
            AppConstants.kHorizontalPadding,
          ),
          width: context.width,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Balance',
                style: context.appTheme.regular16.copyWith(
                  color: AppColors.white,
                ),
              ),
              const Gap(16),
              Text(
                '1000'
                ' جنيه  ',
                style: context.appTheme.bold32.copyWith(
                  color: AppColors.white,
                ),
              ),
              const Gap(16),

              DefaultAppButton(
                backgroundColor: AppColors.secondary,
                text: LocaleKeys.deposit.tr(),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.transactions.tr(),
              style: context.appTheme.medium20.copyWith(
                color: AppColors.primary,
              ),
            ),
            const Gap(16),
            Text(
              LocaleKeys.view_all.tr(),
              style: context.appTheme.regular14.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ],
        ),

        const Gap(16),
        const TransactionListBlocBuilder(),
        const Gap(24),
      ],
    );
  }
}
