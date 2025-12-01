import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/di/di.dart';
import 'package:safi/core/navigation/app_navigation.dart';
import 'package:safi/core/navigation/nav_animation_enum.dart';
import 'package:safi/core/navigation/nav_args.dart';
import 'package:safi/core/translations/locale_keys.g.dart';
import 'package:safi/core/utils/app_dilagos.dart';
import 'package:safi/core/utils/utils.dart';
import 'package:safi/core/widgets/widgets.dart';
import 'package:safi/features/auth/presentation/controller/auth_cubit.dart';
import 'package:safi/features/auth/presentation/controller/auth_state.dart';
import 'package:safi/features/auth/presentation/views/login_view.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import '../../../transactions/presentations/view/wallet_balance_view.dart';
import '../view/user_profile_view.dart';
import 'custom_card_listtile.dart';
import 'pricies_and_address_row_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(25),
        const PriciesAndAddressRowWidget(),
        const Gap(25),
        SlideInRight(
          duration: const Duration(milliseconds: 500),
          child: Text(
            LocaleKeys.my_account.tr(),
            style: context.appTheme.semiBold20,
          ),
        ),
        const Gap(10),
        CustomCardListTile(
          onTap: () => _goTouserProfile(context),
          title: LocaleKeys.profile.tr(),
          icon: CupertinoIcons.profile_circled,
        ),
        const Gap(10),
        CustomCardListTile(
          onTap: () => _goToWalletToRecharge(context),
          title: LocaleKeys.recharge_wallet.tr(),
          icon: CupertinoIcons.creditcard,
        ),
        const Gap(10),
        CustomCardListTile(
          onTap: () => AppBottomSheet.showLanguageBottomSheet(
            context,
            onConfirm: (lang) =>
                EasyLocalization.of(context)!.setLocale(Locale(lang.value)),
          ),
          title: LocaleKeys.language.tr(),
          icon: CupertinoIcons.globe,
        ),
        const Gap(20),
        SlideInRight(
          duration: const Duration(milliseconds: 500),
          child: Text(
            LocaleKeys.about_app.tr(),
            style: context.appTheme.semiBold16,
          ),
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
          child: FadeIn(
            duration: const Duration(milliseconds: 500),
            child: DefaultAppButton(
              borderColor: AppColors.red,
              backgroundColor: AppColors.red,
              text: LocaleKeys.logout.tr(),
              onPressed: () => context.read<AuthCubit>().logout(),
            ),
          ),
        ),
        const Gap(30),
      ],
    );
  }

  Future<Object?> _goToWalletToRecharge(BuildContext context) {
    return AppNavigation.pushNamed(
      context,
      WalletBalanceView.routeName,
      arguments: const NavArgs(
        animation: NavAnimation.fade,
      ),
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

  void _goTouserProfile(BuildContext context) {
    AppNavigation.pushNamed(
      context,
      UserProfileView.routeName,
      arguments: NavArgs(
        animation: NavAnimation.fade,
        data: context.read<ProfileCubit>(),
      ),
    );
  }
}
