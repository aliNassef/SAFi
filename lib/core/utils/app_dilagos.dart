import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_color.dart';
import 'theme/app_theme_extension.dart';

abstract class AppDilagos {
  static void showToast({required String text}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
      fontSize: 18.sp,
    );
  }

  static Future<dynamic> showLoadingBox(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: CircularProgressIndicator.adaptive(
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
              backgroundColor: AppColors.greyBackground,
            ),
          ),
        );
      },
    );
  }

  static void showErrorMessage(
    BuildContext context, {
    required String errMessage,
    int secondes = 4,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.red,
        duration: Duration(seconds: secondes),
        content: Text(
          errMessage,
          style: context.appTheme.regular12.copyWith(color: AppColors.light),
        ),
      ),
    );
  }
}
