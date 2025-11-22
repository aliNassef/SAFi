import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/extensions/padding_extension.dart';
import 'package:safi/core/navigation/app_navigation.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/app_constants.dart';
import 'package:safi/core/utils/app_dilagos.dart';
import 'package:safi/core/utils/utils.dart';
import 'package:safi/core/widgets/default_app_button.dart';
import 'package:safi/features/auth/presentation/controller/auth_cubit.dart';
import 'package:safi/features/auth/presentation/controller/auth_state.dart';
import 'package:safi/features/auth/presentation/views/login_view.dart';

import '../../../../core/extensions/mediaquery_size.dart';
import 'custom_card_listtile.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
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
            Card(
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
          ],
        ),
        const Gap(25),
        Text(
          LocaleKeys.my_account.tr(),
          style: context.appTheme.semiBold20,
        ),
        const Gap(10),
        CustomCardListTile(
          title: LocaleKeys.profile.tr(),
          icon: CupertinoIcons.profile_circled,
        ),
        const Gap(10),
        CustomCardListTile(
          title: LocaleKeys.recharge_wallet.tr(),
          icon: CupertinoIcons.creditcard,
        ),
        const Gap(10),
        CustomCardListTile(
          title: LocaleKeys.language.tr(),
          icon: CupertinoIcons.globe,
        ),
        const Gap(20),
        Text(
          LocaleKeys.about_app.tr(),
          style: context.appTheme.semiBold16,
        ),
        const Gap(10),
        CustomCardListTile(
          title: LocaleKeys.about_app.tr(),
          icon: CupertinoIcons.info,
        ),
        Gap(context.height * 0.14),

        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLogout) {
              AppNavigation.pop(context, useAppRoute: true);
              _goToLogin(context);
            }

            if (state is AuthFailure) {
              AppNavigation.pop(context, useAppRoute: true);
              AppDilagos.showErrorMessage(
                context,
                errMessage: state.errMessage,
              );
            }
            if (state is AuthLoading) {
              AppDilagos.showLoadingBox(context);
            }
          },
          child: DefaultAppButton(
            borderColor: AppColors.red,
            backgroundColor: AppColors.red,
            text: LocaleKeys.logout.tr(),
            onPressed: () => context.read<AuthCubit>().logout(),
          ),
        ),
        const Gap(30),
      ],
    );
  }

  void _goToLogin(BuildContext context) {
    AppNavigation.pushAndRemoveUntil(
      context,
      LoginView.routeName,
      useAppRoute: true,
      (route) => true,
    );
  }
}
