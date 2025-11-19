import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/extensions/padding_extension.dart';

import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../data/models/subscribtion_model.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.subscriptionModel,
  });

  final SubscribtionModel subscriptionModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.package_name.tr(),
                style: context.appTheme.bold20.copyWith(
                  color: AppColors.deepGrey,
                ),
              ),
              Text(
                subscriptionModel.name,
                style: context.appTheme.bold20.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.price.tr(),
                style: context.appTheme.bold20.copyWith(
                  color: AppColors.deepGrey,
                ),
              ),
              Text(
                '${subscriptionModel.price} جم',
                style: context.appTheme.bold20.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.duration.tr(),
                style: context.appTheme.bold20.copyWith(
                  color: AppColors.deepGrey,
                ),
              ),
              Text(
                '${'${subscriptionModel.washesInclude}'} ${LocaleKeys.washes.tr()}',
                style: context.appTheme.bold20.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Text(
            '${LocaleKeys.advantages.tr()}:',
            style: context.appTheme.bold20.copyWith(
              color: AppColors.deepGrey,
            ),
          ),
          ...subscriptionModel.advantages.map(
            (e) => Text(
              '● $e',
              style: context.appTheme.medium20,
            ),
          ),
        ],
      ).withAllPadding(AppConstants.kHorizontalPadding),
    );
  }
}
