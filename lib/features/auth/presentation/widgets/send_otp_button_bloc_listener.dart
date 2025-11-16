import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/nav_animation_enum.dart';
import '../../../../core/navigation/nav_args.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_dilagos.dart';
import '../../../../core/widgets/widgets.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_state.dart';
import '../views/confirm_otp.dart';

class SendOtpButtonBlocListener extends StatelessWidget {
  const SendOtpButtonBlocListener({super.key, required this.phoneController});
  final TextEditingController phoneController;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthFailure ||
          current is AuthLoading ||
          current is AuthCodeSent,
      listener: (context, state) {
        switch (state) {
          case AuthLoading():
            AppDilagos.showLoadingBox(context);
            break;
          case AuthCodeSent():
            AppNavigation.pop(context);
            _navToConfirmOtp(context);
            break;
          case AuthFailure(:final errMessage):
            AppNavigation.pop(context);
            AppDilagos.showErrorMessage(
              context,
              errMessage: errMessage,
            );
            break;
          default:
            break;
        }
      },
      child: DefaultAppButton(
        text: LocaleKeys.login.tr(),
        padding: 16.w,
        onPressed: () {
          AppLogger.info(phoneController.text);
          context.read<AuthCubit>().signInWithphoneNumber(
            phoneNumber: phoneController.text.trim(),
          );
        },
      ),
    );
  }

  void _navToConfirmOtp(BuildContext context) {
    AppNavigation.pushNamed(
      context,
      ConfirmOtp.routeName,
      arguments: const NavArgs(
        animation: NavAnimation.fade,
      ),
    );
  }
}
