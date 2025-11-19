import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/widgets/default_app_button.dart';
import '../../data/models/subscribtion_model.dart';

import '../../../../core/utils/utils.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    this.onPageChanged,
    required this.instance,
    required this.itemCount,
    this.backgroundColor = AppColors.primary,
  });
  final SubscribtionModel instance;
  final int itemCount;
  final Color backgroundColor;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        onPageChanged: onPageChanged,
        height: context.height * 0.6,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        enlargeCenterPage: true,
        enlargeFactor: 1,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
            width: context.width,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(25),
                  Image.asset(
                    AppAssets.subscribtion_image,
                    width: context.width * 0.5,
                  ),
                  Text(
                    instance.name,
                    style: context.appTheme.semiBold20.copyWith(
                      color: AppColors.light,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    '${instance.price} جم',
                    style: context.appTheme.semiBold20.copyWith(
                      color: AppColors.light,
                    ),
                  ),
                  const Gap(20),
                  Divider(
                    indent: context.width * 0.1,
                    endIndent: context.width * 0.1,
                    color: const Color(0xff585454).withValues(alpha: 0.51),
                  ),
                  const Gap(20),
                  ...instance.advantages.map(
                    (e) => Row(
                      children: [
                        Text(
                          '● $e',
                          style: context.appTheme.semiBold16.copyWith(
                            color: AppColors.white,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ).withHorizontalPadding(AppConstants.kHorizontalPadding),
                  ),
                  Gap(context.height * 0.13),
                  DefaultAppButton(
                    borderColor: Colors.transparent,
                    padding: context.width * 0.02,
                    text: LocaleKeys.buy_now.tr(),
                    textColor: backgroundColor,
                    backgroundColor: AppColors.white,
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
    );
  }
}
