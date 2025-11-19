import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/utils/app_dilagos.dart';
import '../../../auth/presentation/controller/auth_cubit.dart';
import '../controller/add_subscription_cubit/add_subscription_cubit.dart';

import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/widgets/widgets.dart';
import '../../data/models/subscribtion_model.dart';
import 'package_card.dart';

class PageViewBody extends StatelessWidget {
  const PageViewBody({
    super.key,
    required this.subscriptionModel,
  });

  final SubscribtionModel subscriptionModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        PackageCard(subscriptionModel: subscriptionModel),
        const Gap(60),
        BlocListener<AddSubscriptionCubit, AddSubscriptionState>(
          listenWhen: (previous, current) =>
              current is AddSubscriptionFailure ||
              current is AddSubscriptionLoaded ||
              current is AddSubscriptionLoading,
          listener: (context, state) {
            switch (state) {
              case AddSubscriptionLoading():
                AppDilagos.showLoadingBox(context);
                break;

              case AddSubscriptionLoaded():
                AppNavigation.pop(context, useAppRoute: true);
                AppDilagos.showToast(text: LocaleKeys.subscriped_done.tr());
                break;

              case AddSubscriptionFailure(:final errMessage):
                AppNavigation.pop(context, useAppRoute: true);
                AppDilagos.showErrorMessage(context, errMessage: errMessage);
                break;
              default:
                break;
            }
          },
          child: DefaultAppButton(
            onPressed: () {
              final userId = context.read<AuthCubit>().getCurrentUser()!.uid;
              context.read<AddSubscriptionCubit>().addSubscripe(
                userId: userId,
                model: subscriptionModel,
              );
            },
            text: LocaleKeys.buy_now.tr(),
          ),
        ),
      ],
    );
  }
}
