import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../controller/get_pricies_service_cubit/get_pricies_service_cubit.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../data/model/pricies_service_model.dart';

class CategoryItemCard extends StatelessWidget {
  const CategoryItemCard({super.key, required this.instance});
  final PriciesServiceModel instance;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: AppColors.primary,
      color: AppColors.white,
      child: Row(
        children: [
          CustomNetworkImage(
            img: instance.img,
            height: 50,
            width: 50,
            radius: 10,
          ),
          const Gap(10),
          Column(
            children: [
              Text(
                instance.item,
                style: context.appTheme.medium20.copyWith(
                  color: AppColors.black,
                ),
              ),
              Text(
                '${instance.price}\$',
                style: context.appTheme.regular16.copyWith(
                  color: AppColors.deepGrey,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: context.width / 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context
                      .read<GetPriciesServiceCubit>()
                      .increaseQty(instance.id),
                  icon: const Icon(
                    Icons.add_circle_outline_outlined,
                    color: AppColors.primary,
                  ),
                ),

                BlocBuilder<GetPriciesServiceCubit, GetPriciesServiceState>(
                  buildWhen: (previous, current) {
                    if (previous is GetPriciesServiceSuccess &&
                        current is GetPriciesServiceSuccess) {
                      final oldItem = previous.data.firstWhere(
                        (e) => e.id == instance.id,
                      );
                      final newItem = current.data.firstWhere(
                        (e) => e.id == instance.id,
                      );

                      return oldItem.qty != newItem.qty;
                    }

                    return false;
                  },
                  builder: (context, state) {
                    if (state is GetPriciesServiceSuccess) {
                      final item = state.data.firstWhere(
                        (e) => e.id == instance.id,
                      );

                      return Text(
                        item.qty.toString(),
                        style: context.appTheme.medium16,
                      );
                    }

                    return Text(
                      instance.qty.toString(),
                      style: context.appTheme.medium16,
                    );
                  },
                ),

                IconButton(
                  onPressed: () => context
                      .read<GetPriciesServiceCubit>()
                      .decreaseQty(instance.id),
                  icon: const Icon(
                    Icons.remove_circle_outline_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ).withAllPadding(10),
    );
  }
}
