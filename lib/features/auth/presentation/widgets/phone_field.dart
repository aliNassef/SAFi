import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/widgets.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xff606161), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xff606161), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xff606161), width: 2),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: LocaleKeys.phone_number.tr(),
      ),
      initialValue: PhoneNumber.parse(
        '+20',
      ),
      validator: PhoneValidator.compose([
        PhoneValidator.required(context, errorText: 'اعد ادخال الرقم'),
        PhoneValidator.validMobile(context, errorText: 'الرقم خاطي'),
      ]),
      countrySelectorNavigator: const CountrySelectorNavigator.page(),
      onChanged: (phone) => controller.text = phone.international,
      enabled: true,
      isCountrySelectionEnabled: true,
      isCountryButtonPersistent: true,
      countryButtonStyle: const CountryButtonStyle(
        showDialCode: true,
        showFlag: true,
        flagSize: 30,
      ),
      cursorColor: AppColors.primary,
    );
  }
}
