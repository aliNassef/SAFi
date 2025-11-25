import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safi/core/utils/theme/app_theme_extension.dart';
import 'package:safi/features/notifications/data/model/notification_model.dart';
import 'package:safi/features/notifications/presentations/controller/notification_cubit/notification_cubit.dart';

import '../../../../core/extensions/date_time_extension.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});
  final NotificationModel notification;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) =>
          current is NotificationMarkAsReadSuccess,
      builder: (context, state) {
        final bgColor =
            state is NotificationMarkAsReadSuccess &&
                state.notifId == notification.id
            ? Colors.transparent
            : notification.isRead
            ? Colors.transparent
            : Colors.grey.shade300;
        return Card(
          child: ListTile(
            tileColor: bgColor,
            onTap: notification.isRead
                ? null
                : () {
                    context.read<NotificationCubit>().markAsRead(
                      notification.id,
                    );
                  },
            title: Text(notification.title, style: context.appTheme.bold16),
            subtitle: Text(
              notification.body,
              style: context.appTheme.regular14,
            ),
            trailing: Text(
              notification.time.toTimeAmPm,
              style: context.appTheme.regular12,
            ),
          ),
        );
      },
    );
  }
}
