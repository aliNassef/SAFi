import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/widgets/custom_failure_widget.dart';
import 'package:safi/features/notifications/presentations/widgets/notification_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/model/notification_model.dart';
import '../controller/notification_cubit/notification_cubit.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) =>
          current is NotificationSuccess ||
          current is NotificationError ||
          current is NotificationLoading,
      builder: (context, state) {
        if (state is NotificationLoading) {
          return Skeletonizer(
            enabled: true,
            child: ListView.separated(
              itemBuilder: (_, index) {
                return NotificationItem(
                  notification: dummyNotificationList[index],
                );
              },
              separatorBuilder: (_, index) => const Gap(16),
              itemCount: dummyNotificationList.length,
            ),
          );
        }
        if (state is NotificationError) {
          return CustomFailureWidget(meesage: state.errMessage);
        }

        if (state is NotificationSuccess) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemBuilder: (_, index) {
              return NotificationItem(notification: state.notifications[index]);
            },
            separatorBuilder: (_, index) => const Gap(16),
            itemCount: state.notifications.length,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
