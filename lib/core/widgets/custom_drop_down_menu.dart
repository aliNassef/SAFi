import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../utils/utils.dart';
import 'widgets.dart';

import '../translations/locale_keys.g.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.hint,
    required this.itemns,
    required this.controller,
  });

  final String hint;
  final List<String> itemns;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return LocaleKeys.field_is_required.tr();
        }
        return null;
      },
      isExpanded: true,
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
      ),

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.secondary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.secondary,
            width: 1,
          ),
        ),
      ),

      items: itemns.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),

      onChanged: (value) {
        controller.text = value ?? hint;
      },
    );
  }
}
