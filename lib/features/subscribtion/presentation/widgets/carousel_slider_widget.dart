import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/extensions/mediaquery_size.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/widgets/default_app_button.dart';
import 'package:safi/features/subscribtion/data/models/subscribtion_model.dart';

import '../../../../core/utils/utils.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key, this.onPageChanged, required this.instance});
  final SubscribtionModel instance;
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
      itemCount: 4,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
            width: context.width,
            decoration: BoxDecoration(
              color: AppColors.primary,
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
                    'data',
                    style: context.appTheme.semiBold20.copyWith(
                      color: AppColors.light,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    '10000.0 د.ع.',
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

                  DefaultAppButton(
                    padding: context.width * 0.02,
                    text: LocaleKeys.buy_now.tr(),
                    textColor: AppColors.primary,
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
