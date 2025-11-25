import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/extensions/mediaquery_size.dart';
import 'package:safi/core/navigation/app_navigation.dart';
import 'package:safi/core/navigation/nav_animation_enum.dart';
import 'package:safi/core/navigation/nav_args.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/app_color.dart';
import 'package:safi/core/utils/app_constants.dart';
import 'package:safi/core/utils/theme/app_theme_extension.dart';
import 'package:safi/core/widgets/custom_failure_widget.dart';
import 'package:safi/core/widgets/default_app_button.dart';
import 'package:safi/features/auth/presentation/controller/auth_cubit.dart';
import 'package:safi/features/transactions/presentations/widgets/tranaction_list_bloc_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/paypal_widget.dart';
import '../cubit/transcation_cubit.dart';
import 'all_transaction_view.dart';

class WalletBalanceViewBody extends StatefulWidget {
  const WalletBalanceViewBody({super.key});

  @override
  State<WalletBalanceViewBody> createState() => _WalletBalanceViewBodyState();
}

class _WalletBalanceViewBodyState extends State<WalletBalanceViewBody> {
  @override
  void initState() {
    super.initState();
    final userId = injector<AuthCubit>().getCurrentUser()!.uid;
    Future.wait([
      context.read<TranscationCubit>().getTransactions(userId, 6),
      context.read<TranscationCubit>().getUserWalletBalance(userId),
    ]);
  }

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
              BlocBuilder<TranscationCubit, TranscationState>(
                buildWhen: (previous, current) =>
                    current is WalletBalanceLoaded ||
                    current is WalletBalanceError ||
                    current is WalletBalanceLoading,
                builder: (context, state) {
                  switch (state) {
                    case WalletBalanceLoading():
                      return Skeletonizer(
                        child: Text(
                          '1000'
                          ' جنيه  ',
                          style: context.appTheme.bold32.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      );
                    case WalletBalanceLoaded(:final walletBalance):
                      return Text(
                        '$walletBalance جنيه  ',
                        style: context.appTheme.bold32.copyWith(
                          color: AppColors.white,
                        ),
                      );
                    case WalletBalanceError(:final errMessage):
                      return CustomFailureWidget(meesage: errMessage);
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
              const Gap(16),

              DefaultAppButton(
                backgroundColor: AppColors.secondary,
                text: LocaleKeys.deposit.tr(),
                onPressed: () {
                  AppNavigation.pushNamed(
                    context,
                    PaypalView.routeName,
                    arguments: NavArgs(
                      animation: NavAnimation.fade,
                      data: 100.toDouble(),
                    ),
                  );
                },
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
        ),

        const Gap(16),
        const TransactionListBlocBuilder(),
        const Gap(24),
      ],
    );
  }
}
