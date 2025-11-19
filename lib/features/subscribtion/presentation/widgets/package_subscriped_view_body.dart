import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/extensions/mediaquery_size.dart';
import 'package:safi/core/extensions/padding_extension.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/app_constants.dart';
import 'package:safi/core/utils/utils.dart';
import 'package:safi/core/widgets/widgets.dart';
import 'package:safi/features/subscribtion/data/models/subscribtion_model.dart';

class PackageSubscripedViewBody extends StatelessWidget {
  const PackageSubscripedViewBody({super.key, required this.package});
  final SubscribtionModel package;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(30),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Image.asset(
                AppAssets.subscribtion_image,
                width: context.width * .6,
              ),
              const Gap(12),
              Text(
                package.name,
                style: context.appTheme.semiBold20.copyWith(
                  color: AppColors.light,
                ),
              ),
              const Gap(12),
              Text(
                '${package.price} جم',
                style: context.appTheme.semiBold20.copyWith(
                  color: AppColors.light,
                ),
              ),
            ],
          ),
        ),
        const Gap(30),

        LinearProgressIndicator(
          value: (package.washesUsed / package.washesInclude!),
          backgroundColor: const Color(0xffD9D9D9),
          color: AppColors.primary,
          borderRadius: BorderRadiusGeometry.circular(5),
          minHeight: 12.h,
        ).withHorizontalPadding(AppConstants.kHorizontalPadding),
        const Gap(20),
        Text(
          '${LocaleKeys.package_used.tr()} ${((package.washesUsed / package.washesInclude!) * 100).toInt()} % ${LocaleKeys.from_package.tr()}',
          style: context.appTheme.semiBold16.copyWith(
            color: const Color(0xff3B3838).withValues(alpha: 0.85),
          ),
        ),
        const Gap(40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.used.tr(),
              style: context.appTheme.semiBold20.copyWith(
                color: const Color(0xff3B3838).withValues(alpha: 0.85),
              ),
            ),
            Text(
              '${package.washesUsed}  ${LocaleKeys.washes.tr()}',
              style: context.appTheme.bold20.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.remaining.tr(),
              style: context.appTheme.semiBold20.copyWith(
                color: const Color(0xff3B3838).withValues(alpha: 0.85),
              ),
            ),
            Text(
              '${package.washesInclude! - package.washesUsed}  ${LocaleKeys.washes.tr()}',
              style: context.appTheme.bold20.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
