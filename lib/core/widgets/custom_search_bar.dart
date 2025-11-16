import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'widgets.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        filled: true,
        hintText: '',
        hintStyle: context.appTheme.bold14.copyWith(
          color: AppColors.black.withValues(alpha: 0.49),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsetsDirectional.only(start: 12),
          child: Icon(Icons.search),
        ),

        prefixIconConstraints: const BoxConstraints(maxWidth: 40),
        prefixIconColor: AppColors.black.withValues(alpha: 0.56),
        fillColor: AppColors.white,
        border: _buildOutLineBorder(),
        enabledBorder: _buildOutLineBorder(),
        focusedBorder: _buildOutLineBorder(),
      ),
    );
  }

  OutlineInputBorder _buildOutLineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: BorderSide(
        color: const Color(0xff606161).withValues(alpha: 0.46),
      ),
    );
  }
}
