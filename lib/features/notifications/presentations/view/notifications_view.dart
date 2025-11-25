import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safi/core/di/service_locator.dart';
import 'package:safi/features/auth/presentation/controller/auth_cubit.dart';
import 'package:safi/features/notifications/presentations/controller/notification_cubit/notification_cubit.dart';
import '../widgets/notification_app_bar.dart';
import '../widgets/notification_view_body.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key, required this.cubit});
  static const String routeName = 'notifications';
  final NotificationCubit cubit;
  @override
  Widget build(BuildContext context) {
    final uid = injector<AuthCubit>().getCurrentUser()!.uid;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: NotificationAppBar(),
      ),
      body: SafeArea(
        child: BlocProvider.value(
          value: cubit..getNotifications(uid),
          child: const NotificationViewBody(),
        ),
      ),
    );
  }
}
