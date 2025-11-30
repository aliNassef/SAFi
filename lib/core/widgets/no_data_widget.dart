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
            const Gap(16),

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const Gap(8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.secondary,
              ),
            ),

            if (actionButton != null) ...[
              const Gap(24),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}
