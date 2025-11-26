import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/widgets/custom_network_image.dart';
import 'package:safi/features/home/data/model/pricies_service_model.dart';

import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';

class ServicePriceWidget extends StatelessWidget {
  const ServicePriceWidget({super.key, required this.instance});
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                instance.item,
                style: context.appTheme.medium20.copyWith(
                  color: AppColors.black,
                ),
              ),
              Text(
                '${instance.price} ${LocaleKeys.pound.tr()}',
                style: context.appTheme.regular16.copyWith(
                  color: AppColors.deepGrey,
                ),
              ),
            ],
          ),
        ],
      ).withAllPadding(10),
    );
  }
}
