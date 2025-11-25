import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../translations/locale_keys.g.dart';
import '../utils/utils.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.hintColor,
    this.isFilled = false,
    this.fillColor,
    this.inputColor,
  });
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final int maxLines;
  final TextInputType keyboardType;
  final Color? hintColor;
  final bool isFilled;
  final Color? fillColor;
  final Color? inputColor;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isSecure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: context.appTheme.regular16.copyWith(
        color: widget.inputColor ?? AppColors.black,
      ),
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.primary,
      obscureText: widget.isPassword ? isSecure : !isSecure,
      obscuringCharacter: '●',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return LocaleKeys.field_is_required.tr();
        }
        return null;
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      maxLines: widget.maxLines,
      controller: widget.controller,
      decoration: InputDecoration(
        fillColor: widget.isFilled ? widget.fillColor : null,
        filled: widget.isFilled,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        hintText: widget.hintText,
        hintStyle: context.appTheme.regular16.copyWith(
          color: widget.hintColor ?? AppColors.black,
        ),
        border: buildBorderStyle(AppColors.secondary),
        enabledBorder: buildBorderStyle(AppColors.secondary),
        focusedBorder: buildBorderStyle(AppColors.secondary),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isSecure = !isSecure;
                  });
                },
                icon: isSecure
                    ? const Icon(
                        Icons.visibility_off,
                        color: AppColors.secondary,
                      )
                    : const Icon(
                        Icons.visibility_sharp,
                        color: AppColors.secondary,
                      ),
              )
            : const SizedBox(),
      ),
    );
  }

  OutlineInputBorder buildBorderStyle(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
