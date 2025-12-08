import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_color.dart';
import 'app_text_style.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.tajawalTextTheme(),
    primarySwatch: Colors.green,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      circularTrackColor: AppColors.primary,
      color: AppColors.grey,
    ),

    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: AppColors.lightGrey,
      selectionHandleColor: AppColors.primary,
      cursorColor: AppColors.primary,
    ),
    menuTheme: const MenuThemeData(
      style: MenuStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      leadingWidth: 0,
    ),

    iconTheme: const IconThemeData(color: AppColors.white),

    extensions: [AppTextStyle.light],
  );
}
