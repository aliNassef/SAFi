import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import '../../../../core/utils/app_dilagos.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/transcation_cubit.dart';

class DepositButtonBlocListener extends StatelessWidget {
  const DepositButtonBlocListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<TranscationCubit, TranscationState>(
      listenWhen: (previous, current) =>
          current is MakePaymentLoading ||
          current is MakePaymentError ||
          current is MakePaymentLoaded,
      listener: (context, state) {
        if (state is MakePaymentLoaded) {}
        if (state is MakePaymentError) {
          AppNavigation.pop(context);

          AppDilagos.showErrorMessage(
            context,
            errMessage: state.errMessage,
          );
        }
      },
      child: DefaultAppButton(
        backgroundColor: AppColors.secondary,
        text: LocaleKeys.deposit.tr(),
        onPressed: () async {
          AppBottomSheet.showCupertinoActionSheet(
            context,
            title: LocaleKeys.deposit.tr(),
            buttonText: LocaleKeys.deposit.tr(),
            onConfirm: (amount) {
              context.read<TranscationCubit>().makePayment(
                amount.toString(),
                "EGP",
              );
            },
          );
        },
      ),
    );
  }
}
