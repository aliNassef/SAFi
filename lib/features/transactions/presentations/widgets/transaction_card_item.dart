import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class TransactionCardItem extends StatelessWidget {
  const TransactionCardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
  });
  final String title, subtitle, amount;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          CupertinoIcons.money_dollar_circle,
          size: 28,
        ),
        title: Text(
          title,
          style: context.appTheme.semiBold16.copyWith(
            color: const Color(0xff3B3838).withValues(alpha: 0.85),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: context.appTheme.regular14.copyWith(
            color: const Color(0xff3B3838).withValues(alpha: 0.85),
          ),
        ),
        trailing: Text(
          '$amount جنيه',
          style: context.appTheme.semiBold16.copyWith(
            color: const Color(0xff3B3838).withValues(alpha: 0.85),
          ),
        ),
      ),
    );
  }
}
