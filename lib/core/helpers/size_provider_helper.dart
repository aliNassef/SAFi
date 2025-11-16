import 'package:flutter/material.dart';

class SizeProviderHelper {
  final BoxConstraints constraints;

  SizeProviderHelper({required this.constraints});

  bool get isMobile => constraints.maxWidth < 600;

  bool get isTablet =>
      constraints.maxWidth >= 600 && constraints.maxWidth < 1200;

  bool get isWeb => constraints.maxWidth >= 1200;

  // Padding values
  static const double _mobilePadding = 16.0;
  static const double _tabletPadding = 24.0;
  static const double _webPadding = 32.0;

  // Radius values
  static const double _mobileRadius = 8.0;
  static const double _tabletRadius = 12.0;
  static const double _webRadius = 16.0;

  // Spacing values
  static const double _mobileSpace = 8.0;
  static const double _tabletSpace = 12.0;
  static const double _webSpace = 16.0;

  // Responsive Padding
  EdgeInsets get responsivePadding {
    if (isMobile) {
      return const EdgeInsets.all(_mobilePadding);
    } else if (isTablet) {
      return const EdgeInsets.all(_tabletPadding);
    } else {
      return const EdgeInsets.all(_webPadding);
    }
  }

  // Responsive Radius
  BorderRadius get responsiveRadius {
    if (isMobile) {
      return BorderRadius.circular(_mobileRadius);
    } else if (isTablet) {
      return BorderRadius.circular(_tabletRadius);
    } else {
      return BorderRadius.circular(_webRadius);
    }
  }

  // Responsive Spacing
  double get responsiveSpace {
    if (isMobile) {
      return _mobileSpace;
    } else if (isTablet) {
      return _tabletSpace;
    } else {
      return _webSpace;
    }
  }
}
