import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/date_time_extension.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../cubit/transcation_cubit.dart';
import 'transaction_card_item.dart';

class AllTransactionViewBody extends StatelessWidget {
  const AllTransactionViewBody({
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
            return Skeletonizer(
              enabled: true,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (_, _) {
                  return const TransactionCardItem(
                    title: 'title',
                    subtitle: 'subtitle',
                    amount: 'amount',
                  );
                },
                separatorBuilder: (_, _) => const Gap(16),
                itemCount: 10,
              ),
            );
          case TranscationError(:final errMessage):
            return CustomFailureWidget(meesage: errMessage);
          case TranscationLoaded(:final transactions):
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) {
                return TransactionCardItem(
                  title: transactions[index].type,
                  subtitle: transactions[index].date.toDDMMYYYY,
                  amount: transactions[index].amount.toString(),
                );
              },
              separatorBuilder: (_, _) => const Gap(16),
              itemCount: transactions.length,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
