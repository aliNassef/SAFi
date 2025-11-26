import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/widgets/custom_failure_widget.dart';
import '../../../home/data/model/pricies_service_model.dart';
import '../controller/profile_cubit/profile_cubit.dart';
import 'service_price_widget.dart';

class AllServiciesPriciesViewBody extends StatefulWidget {
  const AllServiciesPriciesViewBody({
    super.key,
  });

  @override
  State<AllServiciesPriciesViewBody> createState() =>
      _AllServiciesPriciesViewBodyState();
}

class _AllServiciesPriciesViewBodyState
    extends State<AllServiciesPriciesViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getAllServicePrices();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is GetAllServicePricesSuccess ||
          current is GetAllServicePricesError ||
          current is GetAllServicePricesLoading,
      builder: (context, state) {
        if (state is GetAllServicePricesSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.prices.length,
            itemBuilder: (context, index) {
              return ServicePriceWidget(
                instance: state.prices[index],
              );
            },
          );
        }
        if (state is GetAllServicePricesError) {
          return CustomFailureWidget(meesage: state.errMessage);
        }

        if (state is GetAllServicePricesLoading) {
          return Skeletonizer(
            enabled: true,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dummyPriciesServiceModel.length,
              itemBuilder: (context, index) {
                return ServicePriceWidget(
                  instance: dummyPriciesServiceModel[index],
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
