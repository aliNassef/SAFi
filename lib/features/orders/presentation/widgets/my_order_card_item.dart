import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/extensions/padding_extension.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../home/data/model/pricies_service_model.dart';

class MyOrderCardItem extends StatelessWidget {
  const MyOrderCardItem({
    super.key, required this.order,
  });
  final PriciesServiceModel order;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.white,
      child: Row(
        children: [
          CustomNetworkImage(
            img: order.img,
            width: 50,
            height: 50,
            radius: 15,
          ),
          const Gap(10),
          Column(
            children: [
              Text(order.item, style: context.appTheme.medium16),
              Text(
                '${order.price}\$',
                style: context.appTheme.medium14.copyWith(
                  color: AppColors.deepGrey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text('qty: ${order.qty}', style: context.appTheme.medium16),
        ],
      ).withAllPadding(AppConstants.kHorizontalPadding),
    );
  }
}
