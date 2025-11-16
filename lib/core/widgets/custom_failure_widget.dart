import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/theme/app_theme_extension.dart';

class CustomFailureWidget extends StatelessWidget {
  const CustomFailureWidget({super.key, required this.meesage});
  final String meesage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        meesage,
        style: context.appTheme.bold24.copyWith(color: AppColors.red),
      ),
    );
  }
}
