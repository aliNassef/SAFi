import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safi/core/di/service_locator.dart';
import 'package:safi/core/extensions/padding_extension.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/app_constants.dart';
import 'package:safi/features/auth/presentation/controller/auth_cubit.dart';
import 'package:safi/features/subscribtion/presentation/controller/subscribtion_cubit/subscribtion_cubit.dart';
import 'package:safi/features/subscribtion/presentation/widgets/package_app_bar.dart';
import 'package:safi/features/subscribtion/presentation/widgets/package_subscriped_view_body.dart';
import 'subscribtion_view.dart';

class PackageSubscripedView extends StatelessWidget {
  const PackageSubscripedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = injector<SubscribtionCubit>();
        final userId = context.read<AuthCubit>().getCurrentUser()?.uid;
        if (userId != null) {
          cubit.checkUserPackageOrGetSubscriptions(userId);
        }
        return cubit;
      },
      child: BlocBuilder<SubscribtionCubit, SubscribtionState>(
        builder: (context, state) {
          if (state is GetUserPackageLoading || state is SubscribtionLoading) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: PackageAppBar(title: LocaleKeys.package_details.tr()),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is GetUserPackageLoaded && state.package != null) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: PackageAppBar(title: LocaleKeys.package_details.tr()),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child:
                      PackageSubscripedViewBody(
                        package: state.package!,
                      ).withHorizontalPadding(
                        AppConstants.kHorizontalPadding,
                      ),
                ),
              ),
            );
          }

          return const SubscribtionView();
        },
      ),
    );
  }
}
