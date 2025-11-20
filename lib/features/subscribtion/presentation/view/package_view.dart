import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_constants.dart';
import '../controller/add_subscription_cubit/add_subscription_cubit.dart';
import '../../data/models/subscribtion_model.dart';
import '../widgets/package_app_bar.dart';
import '../widgets/page_view_body.dart';

class PackageView extends StatelessWidget {
  const PackageView({super.key, required this.subscriptionModel});
  static const routeName = 'PackageView';
  final SubscribtionModel subscriptionModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child:
            PackageAppBar(
              title: LocaleKeys.packages.tr(),
            ).withHorizontalPadding(
              AppConstants.kHorizontalPadding,
            ),
      ),

      body: SafeArea(
        child:
            BlocProvider(
              create: (context) => injector<AddSubscriptionCubit>(),
              child: PackageViewBody(subscriptionModel: subscriptionModel),
            ).withHorizontalPadding(
              AppConstants.kHorizontalPadding,
            ),
      ),
    );
  }
}
