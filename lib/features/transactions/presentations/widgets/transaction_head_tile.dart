import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/nav_animation_enum.dart';
import '../../../../core/navigation/nav_args.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
import '../cubit/transcation_cubit.dart';
import 'all_transaction_view.dart';

class TransactionsHeadTile extends StatelessWidget {
  const TransactionsHeadTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LocaleKeys.transactions.tr(),
          style: context.appTheme.medium20.copyWith(
            color: AppColors.primary,
          ),
        ),
        const Gap(16),
        TextButton(
          onPressed: () {
            AppNavigation.pushNamed(
              context,
              AllTransactionView.routeName,
              arguments: NavArgs(
                animation: NavAnimation.fade,
                data: context.read<TranscationCubit>(),
              ),
            );
          },
          child: Text(
            LocaleKeys.view_all.tr(),
            style: context.appTheme.regular14.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
