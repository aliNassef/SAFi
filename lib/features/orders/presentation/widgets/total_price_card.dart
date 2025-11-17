import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
import '../../../home/data/model/price_args_model.dart';

class TotalPriceCard extends StatelessWidget {
  const TotalPriceCard({
    super.key,
    required this.instance,
  });

  final PriceArgsModel instance;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            '${instance.total}\$',
            style: context.appTheme.regular14.copyWith(
              color: AppColors.deepGrey,
            ),
          ),
        ],
      ),
    );
  }
}
