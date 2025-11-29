import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/nav_animation_enum.dart';
import '../../../../core/navigation/nav_args.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../../data/model/price_args_model.dart';
import '../../data/model/service_model.dart';
import '../controller/get_services_cubit/get_services_cubit.dart';
import '../views/pricies_view.dart';
import 'home_service.dart';

class ServicesListBlocBuilder extends StatelessWidget {
  const ServicesListBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetServicesCubit, GetServicesState>(
      buildWhen: (previous, current) =>
          current is GetServicesFailure ||
          current is GetServicesLoading ||
          current is GetServicesSuccess,
      builder: (context, state) {
        switch (state) {
          case GetServicesLoading():
            return SliverSkeletonizer(
              enabled: true,
              child: SliverList.separated(
                itemBuilder: (_, index) => HomeService(
                  onTap: () {},
                  onExpansionChanged: (val) {},
                  serviceModel: dummyServices[index],
                ),
                separatorBuilder: (_, _) => const Gap(16),
                itemCount: 3,
              ),
            );
          case GetServicesFailure(:String errMessage):
            return SliverToBoxAdapter(
              child: CustomFailureWidget(
                meesage: errMessage,
              ),
            );
          case GetServicesSuccess(:final services):
            return SliverList.separated(
              itemBuilder: (_, index) => HomeService(
                onTap: () async {
                  final prices = await _navigateToPriceList(
                    context,
                    services[index].id,
                  );

                  // ignore: use_build_context_synchronously
                  context.read<GetServicesCubit>().setOrderDetails(prices);
                },
                onExpansionChanged: (val) {
                  context.read<GetServicesCubit>().selectService(
                    services[index].id,
                    val,
                  );
                },
                serviceModel: services[index],
              ),
              separatorBuilder: (_, _) => const Gap(16),
              itemCount: services.length,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Future<PriceArgsModel> _navigateToPriceList(
    BuildContext context,
    String serviceId,
  ) async {
    final prices = await AppNavigation.pushNamed(
      context,
      PriciesView.routeName,
      useAppRoute: true,
      arguments: NavArgs(animation: NavAnimation.fade, data: serviceId),
    );
    return prices as PriceArgsModel;
  }
}
