import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safi/core/enums/lang_enum.dart';

import '../navigation/app_navigation.dart';
import '../translations/locale_keys.g.dart';
import '../widgets/widgets.dart';

class AppBottomSheet {
  static Future<void> showAmountBottomSheet(
    BuildContext context, {
    required String title,
    required String buttonText,
    required Function(double amount) onConfirm,
  }) {
    final TextEditingController amountController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Gap(20),
                    TextFormField(
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: LocaleKeys.enter_amount.tr(),
                        hintText: LocaleKeys.enter_amount.tr(),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.please_enter_an_amount.tr();
                        }
                        if (double.tryParse(value) == null) {
                          return LocaleKeys.please_enter_a_valid_number.tr();
                        }
                        if (double.parse(value) <= 0) {
                          return LocaleKeys.amount_must_be_greater_than_zero
                              .tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      child: DefaultAppButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            final double amount = double.parse(
                              amountController.text,
                            );
                            onConfirm(amount);
                            Navigator.pop(context);
                          }
                        },
                        text: buttonText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showCupertinoActionSheet(
    BuildContext context, {
    required String title,
    required String buttonText,
    required Function(double amount) onConfirm,
  }) {
    final TextEditingController amountController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          message: Material(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'),
                            ),
                          ],
                          decoration: InputDecoration(
                            labelText: LocaleKeys.enter_amount.tr(),
                            hintText: LocaleKeys.enter_amount.tr(),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.please_enter_an_amount.tr();
                            }
                            if (double.tryParse(value) == null) {
                              return LocaleKeys.please_enter_a_valid_number
                                  .tr();
                            }
                            if (double.parse(value) <= 0) {
                              return LocaleKeys.amount_must_be_greater_than_zero
                                  .tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: DefaultAppButton(
                            text: buttonText,
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                final double amount = double.parse(
                                  amountController.text,
                                );
                                onConfirm(amount);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showLanguageBottomSheet(
    BuildContext context, {
    required Function(LangEnum lang) onConfirm,
  }) {
    return showCupertinoModalPopup(
      barrierColor: Colors.black.withValues(alpha: 0.5),

      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text('Language'),
          actions: [
            CupertinoActionSheetAction(
              child: const Text('English'),
              onPressed: () {
                onConfirm(LangEnum.en);
                AppNavigation.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Arabic'),
              onPressed: () {
                onConfirm(LangEnum.ar);
                AppNavigation.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<ImageSource?> showImageSourceDialog(
    BuildContext context,
  ) async {
    return showCupertinoModalPopup(
      barrierColor: Colors.black.withValues(alpha: 0.5),
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text('Choose Image Source'),
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Gallery'),
              onPressed: () {
                AppNavigation.pop(context, result: ImageSource.gallery);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () {
                AppNavigation.pop(context, result: ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }
}
