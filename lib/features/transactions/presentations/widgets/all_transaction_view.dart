import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../auth/presentation/controller/auth_cubit.dart';
import '../cubit/transcation_cubit.dart';
import 'all_transaction_view_body.dart';
import 'transactions_app_bar.dart';

class AllTransactionView extends StatefulWidget {
  const AllTransactionView({super.key, required this.cubit});
  static const String routeName = 'all_transaction_view';
  final TranscationCubit cubit;
  @override
  State<AllTransactionView> createState() => _AllTransactionViewState();
}

class _AllTransactionViewState extends State<AllTransactionView> {
  @override
  void initState() {
    super.initState();
    final userId = injector<AuthCubit>().getCurrentUser()!.uid;
    widget.cubit.getTransactions(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TransactionAppBar(title: LocaleKeys.transactions.tr()),
      ),
      body: BlocProvider.value(
        value: widget.cubit,
        child: const SafeArea(
          child: AllTransactionViewBody(),
        ),
      ),
    );
  }
}
