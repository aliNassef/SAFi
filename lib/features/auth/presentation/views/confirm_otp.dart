import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/navigation/nav_animation_enum.dart';
import '../../../../core/navigation/nav_args.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_dilagos.dart';
import '../../../../core/widgets/default_app_button.dart';
import '../../../layout/presentation/views/layout_vieew.dart';
import '../controller/auth_cubit.dart';
import '../controller/auth_state.dart';
import '../widgets/otp_field.dart';

class ConfirmOtp extends StatefulWidget {
  const ConfirmOtp({super.key});
  static const routeName = 'ConfirmOTP';

  @override
  State<ConfirmOtp> createState() => _ConfirmOtpState();
}

class _ConfirmOtpState extends State<ConfirmOtp> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  AppNavigation.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                ),
              ),

              Gap(context.height * .3),
              OtpFieldWidget(
                controller: _controller,
              ),
              Gap(context.height * .4),
              BlocListener<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    current is AuthLoading ||
                    current is AuthFailure ||
                    current is AuthSuccess,
                listener: (context, state) {
                  switch (state) {
                    case AuthLoading():
                      AppDilagos.showLoadingBox(context);
                      break;
                    case AuthFailure(:final errMessage):
                      AppDilagos.showErrorMessage(
                        context,
                        errMessage: errMessage,
                      );
                      break;
                    case AuthSuccess():
                      AppDilagos.showToast(text: 'User Login Successfully');
                      _goToLayout(context);
                      break;
                    default:
                      break;
                  }
                },
                child: DefaultAppButton(
                  onPressed: () {
                    context.read<AuthCubit>().verifyOtp(
                      otp: _controller.text.trim(),
                    );
                  },
                  text: LocaleKeys.send.tr(),
                ),
              ),
            ],
          ).withHorizontalPadding(16),
        ),
      ),
    );
  }

  void _goToLayout(context) {
    AppNavigation.pushNamed(
      context,
      LayoutView.routeName,
      arguments: const NavArgs(
        animation: NavAnimation.fade,
      ),
    );
  }
}
