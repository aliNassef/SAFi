import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../data/model/pricies_service_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/widgets/custom_failure_widget.dart';
import '../controller/get_pricies_service_cubit/get_pricies_service_cubit.dart';
import 'category_item_card.dart';

class PriceViewBody extends StatelessWidget {
  const PriceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPriciesServiceCubit, GetPriciesServiceState>(
      buildWhen: (previous, current) =>
          current is GetPriciesServiceLoading ||
          current is GetPriciesServiceFailure ||
          current is GetPriciesServiceSuccess,
      builder: (context, state) {
        switch (state) {
          case GetPriciesServiceLoading():
            return Skeletonizer(
              enabled: true,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (_, index) {
                  return CategoryItemCard(
                    instance: dummyPriciesServiceModel[index],
                  );
                },
                separatorBuilder: (_, _) => const Gap(16),
                itemCount: dummyPriciesServiceModel.length,
              ),
            );
          case GetPriciesServiceSuccess(:final data):
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) {
                return CategoryItemCard(
                  instance: data[index],
                );
              },
              separatorBuilder: (_, _) => const Gap(16),
              itemCount: data.length,
            );

          case GetPriciesServiceFailure(:final errorMessage):
            return CustomFailureWidget(meesage: errorMessage);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
