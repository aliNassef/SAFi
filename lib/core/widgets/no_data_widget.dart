import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_color.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.actionButton,
  });
  final String title;
  final String message;
  final IconData icon;
  final Widget? actionButton;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 64,
              color: AppColors.grey,
            ),
            Gap(16),

            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Gap(8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondary,
              ),
            ),

            if (actionButton != null) ...[
              Gap(24),
              actionButton!,
            ],
          ],
        ),
      ),
    );
    ;
  }
}
