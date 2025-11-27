import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safi/core/navigation/app_navigation.dart';
import 'package:safi/core/navigation/nav_animation_enum.dart';
import 'package:safi/core/navigation/nav_args.dart';
import 'package:safi/core/widgets/widgets.dart';
import 'package:safi/features/profile/presentation/view/all_servicies_pricies_view.dart';

import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../controller/profile_cubit/profile_cubit.dart';
import '../view/address_view.dart';

class PriciesAndAddressRowWidget extends StatelessWidget {
  const PriciesAndAddressRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FadeIn(
          duration: const Duration(milliseconds: 500),
          child: InkWell(
            onTap: () {
              AppNavigation.pushNamed(
                context,
                AllServiciesPriciesView.routeName,
                arguments: NavArgs(
                  animation: NavAnimation.fade,
                  data: profileCubit,
                ),
              );
            },
            child: Card(
              color: AppColors.white,
              elevation: 2,
              child: Column(
                children: [
                  SvgPicture.asset(AppAssets.price_icon, width: 28, height: 33),
                  Text(
                    LocaleKeys.prices.tr(),
                    style: context.appTheme.semiBold16.copyWith(
                      color: const Color(0xff3B3838).withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ).withAllPadding(AppConstants.kHorizontalPadding),
            ),
          ),
        ),
        FadeIn(
          duration: const Duration(milliseconds: 500),
          child: InkWell(
            onTap: () {
              AppNavigation.pushNamed(
                context,
                AddressView.routeName,
                arguments: const NavArgs(
                  animation: NavAnimation.fade,
                ),
              );
            },
            child: Card(
              color: AppColors.white,
              elevation: 2,
              child: Column(
                children: [
                  SvgPicture.asset(
                    AppAssets.address_icon,
                    width: 28,
                    height: 33,
                  ),
                  Text(
                    LocaleKeys.address.tr(),
                    style: context.appTheme.semiBold16.copyWith(
                      color: const Color(0xff3B3838).withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ).withAllPadding(AppConstants.kHorizontalPadding),
            ),
          ),
        ),
      ],
    );
  }
}
