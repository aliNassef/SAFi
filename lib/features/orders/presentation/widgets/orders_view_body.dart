import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:safi/core/utils/app_constants.dart';
import 'package:safi/core/widgets/custom_failure_widget.dart';
import 'package:safi/features/orders/data/model/orders_model.dart';
import 'package:safi/features/orders/presentation/controller/order_cubit/order_cubit.dart';
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
            return ListView.separated(
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
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
