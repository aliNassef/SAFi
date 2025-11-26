import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';

class CustomCardListTile extends StatelessWidget {
  const CustomCardListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          size: 28,
        ),
        title: Text(
          title,
          style: context.appTheme.semiBold16.copyWith(
            color: const Color(0xff3B3838).withValues(alpha: 0.85),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
