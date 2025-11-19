import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/translations/locale_keys.g.dart';
import '../../../../core/utils/theme/app_theme_extension.dart';
import '../../../auth/presentation/controller/auth_cubit.dart';
import '../controller/order_cubit/order_cubit.dart';
import '../widgets/orders_view_body.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.my_orders.tr(),
          style: context.appTheme.medium20,
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            injector<OrderCubit>()..getOrders(user!.phoneNumber!),
        child: const SafeArea(
          child: OrdersViewBody(),
        ),
      ),
    );
  }
}
