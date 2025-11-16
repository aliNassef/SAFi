import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../controller/get_pricies_service_cubit/get_pricies_service_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/widgets/widgets.dart';

import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';

class PriceViewBottomSheet extends StatelessWidget {
  const PriceViewBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),

            decoration: BoxDecoration(
              color: const Color(0xffE8E2E2).withValues(alpha: .81),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.tornado_outlined,
                  color: AppColors.deepGrey,
                ),
                const Gap(10),
                Text(LocaleKeys.total_amount.tr()),
                const Spacer(),
                BlocBuilder<GetPriciesServiceCubit, GetPriciesServiceState>(
                  buildWhen: (previous, current) =>
                      current is GetPriciesServiceLoading ||
                      current is GetPriciesServiceSuccess,
                  builder: (context, state) {
                    final total = state is GetPriciesServiceSuccess
                        ? state.totalPrice
                        : 0;
                    return Skeletonizer(
                      enabled: state is GetPriciesServiceLoading,
                      child: Text(
                        '$total\$',
                        style: context.appTheme.regular14.copyWith(
                          color: AppColors.deepGrey,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Gap(40),
        ],
      ),
    );
  }
}
