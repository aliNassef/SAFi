import 'package:flutter/material.dart';
import 'package:safi/core/utils/theme/app_theme_extension.dart';
import 'package:safi/features/notifications/data/model/notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});
  final NotificationModel notification;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: Text(notification.title, style: context.appTheme.bold16),
        subtitle: Text(notification.body, style: context.appTheme.regular14),
      ),
    );
  }
}
