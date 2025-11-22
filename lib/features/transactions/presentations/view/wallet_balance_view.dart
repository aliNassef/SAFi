import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safi/core/extensions/padding_extension.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/app_constants.dart';
import 'package:safi/features/auth/presentation/controller/auth_cubit.dart';

import '../../../../core/di/service_locator.dart';
import '../cubit/transcation_cubit.dart';
import '../widgets/transactions_app_bar.dart';
import '../widgets/wallet_balance_view_body.dart';

class WalletBalanceView extends StatelessWidget {
  const WalletBalanceView({super.key});

  static const String routeName = 'wallet_balance_view';

  @override
  Widget build(BuildContext context) {
    final userId = injector<AuthCubit>().getCurrentUser()!.uid;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TransactionAppBar(title: LocaleKeys.wallet_balance.tr()),
      ),
      body: BlocProvider(
        create: (context) =>
            injector<TranscationCubit>()..getTransactions(userId, 6),
        child: SafeArea(
          child: const WalletBalanceViewBody().withHorizontalPadding(
            AppConstants.kHorizontalPadding,
          ),
        ),
      ),
    );
  }
}
