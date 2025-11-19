import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:safi/features/auth/presentation/controller/auth_cubit.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../../data/model/orders_model.dart';
import '../controller/order_cubit/order_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'order_card_item.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (previous, current) =>
          current is GetOrderSuccess ||
          current is OrderFailure ||
          current is OrderLoading,
      builder: (context, state) {
        switch (state) {
          case OrderLoading():
            return Skeletonizer(
              enabled: true,
              containersColor: Colors.grey.shade300,
              child: ListView.separated(
                itemBuilder: (_, index) {
                  return OrderCardItem(
                    order: dummyOrders[index],
                  );
                },
                separatorBuilder: (_, _) => const Gap(16),
                itemCount: dummyOrders.length,
              ),
            );

          case OrderFailure(:final errMessage):
            return CustomFailureWidget(meesage: errMessage);
          case GetOrderSuccess(:final orders):
            return RefreshIndicator(
              onRefresh: () async {
                final userId = context
                    .read<AuthCubit>()
                    .getCurrentUser()!
                    .phoneNumber;
                context.read<OrderCubit>().getOrders(userId!);
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.kHorizontalPadding,
                  vertical: AppConstants.kHorizontalPadding,
                ),
                itemBuilder: (_, index) {
                  return OrderCardItem(
                    order: orders[index],
                  );
                },
                separatorBuilder: (_, _) => const Gap(16),
                itemCount: orders.length,
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
