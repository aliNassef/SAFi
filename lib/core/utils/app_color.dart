import 'package:flutter/material.dart';

class AppColors {
  // Core palette
  static const Color primary = Color(0xFF098181); // #098181
  static const Color secondary = Color(0xFFF88E15); // #F88E15
  static const Color black = Color(0xFF000000); // #000000
  static const Color white = Color(0xFFFFFFFF); // #FFFFFF
  static const Color deepGrey = Color(0xFF585454); // #585454
  static const Color lightGrey = Color(0xFFCFC1C1); // #CFC1C1
  static const Color mediumGrey = Color(0xFFA89D9D); // #A89D9D
  static const Color paleGrey = Color(0xFFBAB1B1); // #BAB1B1

  // Legacy/extra palette (kept for compatibility)
  static const Color orange = Color(0xFFF95B1C);
  static Color grey = const Color(0xFF090F1F).withValues(alpha: 0.5);
  static const Color light = Color(0xFFF3F4F6);
  static const Color red = Color(0xFFEF2A39);
  static const Color brown = Color(0xFF3C2F2F);
  static const Color green = Color(0xFF3A813F);
  static Color greyBackground = Colors.black.withValues(alpha: 0.1);
  static Color greyBorder = const Color(0xff3b4cf2).withValues(alpha: 0.1);
}
