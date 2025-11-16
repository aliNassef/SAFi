import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import '../../../../core/utils/app_color.dart';

class OtpFieldWidget extends StatelessWidget {
  const OtpFieldWidget({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return OtpPinField(
      autoFillEnable: false,
      textInputAction: TextInputAction.done,
      onSubmit: (text) {
        controller.text = text;
      },
      onChange: (text) {
        controller.text = text;
      },
      onCodeChanged: (code) {
        controller.text = code;
      },
      otpPinFieldStyle: const OtpPinFieldStyle(
        activeFieldBorderGradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary,
          ],
        ),
        filledFieldBorderGradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary,
          ],
        ),
        defaultFieldBorderGradient: LinearGradient(
          colors: [
            AppColors.secondary,
            AppColors.secondary,
          ],
        ),
      ),
      maxLength: 6,
      showCursor: true,
      cursorColor: AppColors.primary,
      showCustomKeyboard: false,
      cursorWidth: 3,
      mainAxisAlignment: MainAxisAlignment.center,
      otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
    );
  }
}
