import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/send_otp_button_bloc_listener.dart';
import '../../../../core/extensions/mediaquery_size.dart';
import '../../../../core/extensions/padding_extension.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/utils.dart';
import '../widgets/phone_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String routeName = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _phoneNumber;
  @override
  void initState() {
    super.initState();
    _phoneNumber = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: context.height * .7,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(15),
                    ),
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  top: context.height * .1,
                  child: Text(
                    LocaleKeys.splash_title.tr(),
                    style: context.appTheme.bold40.copyWith(
                      color: AppColors.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: context.height * .08,
                  child: Image.asset(AppAssets.shaddow),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: context.height * .2,
                  child: Image.asset(AppAssets.login),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: context.height * .45,
                  child: Image.asset(AppAssets.shaddow),
                ),
              ],
            ),
            const Gap(40),
            PhoneField(
              controller: _phoneNumber,
            ).withHorizontalPadding(16),
            const Gap(30),
            SendOtpButtonBlocListener(phoneController: _phoneNumber),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
