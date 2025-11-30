import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/date_time_extension.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../cubit/transcation_cubit.dart';
import 'transaction_card_item.dart';

class TransactionListBlocBuilder extends StatelessWidget {
  const TransactionListBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranscationCubit, TranscationState>(
      buildWhen: (previous, current) =>
          current is TranscationLoaded ||
          current is TranscationError ||
          current is TranscationLoading,
      builder: (context, state) {
        switch (state) {
          case TranscationLoading():
            return Expanded(
              child: Skeletonizer(
                enabled: true,
                child: ListView.separated(
                  itemBuilder: (_, _) {
                    return const TransactionCardItem(
                      title: 'title',
                      subtitle: 'subtitle',
                      amount: 'amount',
                    );
                  },
                  separatorBuilder: (_, _) => const Gap(16),
                  itemCount: 4,
                ),
              ),
            );
          case TranscationError(:final errMessage):
            return CustomFailureWidget(meesage: errMessage);
          case TranscationLoaded(:final transactions):
            if (transactions.isEmpty) {
              return const NoDataWidget(
                title: 'No Transactions',
                message: 'You have no transactions yet',
                icon: Icons.shopping_cart_outlined,
              );
            }
            return Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) {
                  return TransactionCardItem(
                    title: transactions[index].type,
                    subtitle: transactions[index].date.toDDMMYYYY,
                    amount: transactions[index].amount.toString(),
                  );
                },
                separatorBuilder: (_, _) => const Gap(16),
                itemCount: transactions.length,
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
