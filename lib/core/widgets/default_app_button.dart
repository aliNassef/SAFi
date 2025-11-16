import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/theme/app_theme_extension.dart';
import 'widgets.dart';
import '../extensions/padding_extension.dart';

class DefaultAppButton extends StatelessWidget {
  const DefaultAppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.light,
    this.icon = const SizedBox(),
    this.padding = 0,
    this.vpadding = 11,
    this.radius = 15,
    this.borderWidth = 1,
    this.borderColor = AppColors.primary,
  });
  final String text;
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Widget icon;
  final double padding;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final double vpadding;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: vpadding.r),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        alignment: Alignment.center,
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: context.appTheme.bold20.copyWith(color: textColor)),
          icon,
        ],
      ),
    ).withHorizontalPadding(padding);
  }
}
