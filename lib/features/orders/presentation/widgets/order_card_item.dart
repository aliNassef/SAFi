import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/enums/order_status_enum.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../data/model/orders_model.dart';

class OrderCardItem extends StatelessWidget {
  const OrderCardItem({
    super.key,
    required this.order,
  });

  final OrdersModel order;

  Color _statusColor(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.pendding:
        return Colors.orange;
      case OrderStatusEnum.accepted:
        return Colors.green;
      case OrderStatusEnum.rejected:
        return Colors.red;
      case OrderStatusEnum.onTheWay:
        return AppColors.primary;
    }
  }

  IconData _statusIcon(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.pendding:
        return Icons.pending_outlined;
      case OrderStatusEnum.accepted:
        return Icons.check_circle_outline;
      case OrderStatusEnum.rejected:
        return Icons.cancel_outlined;
      case OrderStatusEnum.onTheWay:
        return Icons.local_shipping_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(order.status);
    final statusIcon = _statusIcon(order.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: statusColor.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with status badge
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  statusColor.withValues(alpha: 0.1),
                  statusColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    statusIcon,
                    color: statusColor,
                    size: 24,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${order.serviceId.length > 8 ? order.serviceId.substring(0, 8) : order.serviceId}',
                        style: context.appTheme.bold20.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        order.userId.length > 8
                            ? 'User: ${order.userId.substring(0, 8)}...'
                            : 'User: ${order.userId}',
                        style: context.appTheme.regular14.copyWith(
                          color: AppColors.deepGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: statusColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    order.status.name.toUpperCase(),
                    style: context.appTheme.bold14.copyWith(
                      color: AppColors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Order items section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Items (${order.orders.length})',
                  style: context.appTheme.semiBold16.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const Gap(12),
                ...order.orders
                    .take(3)
                    .map(
                      (item) => _OrderItemRow(item: item, context: context),
                    ),
                if (order.orders.length > 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '+ ${order.orders.length - 3} more items',
                      style: context.appTheme.regular14.copyWith(
                        color: AppColors.primary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.lightGrey.withValues(alpha: 0.5),
            indent: 20,
            endIndent: 20,
          ),

          // Payment and address info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _InfoRow(
                  icon: Icons.payment_outlined,
                  label: 'Payment Method',
                  value: order.paymentMethod,
                  context: context,
                ),
                const Gap(12),
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  value: order.address,
                  context: context,
                ),
                if (order.notes != null && order.notes!.isNotEmpty) ...[
                  const Gap(12),
                  _InfoRow(
                    icon: Icons.note_outlined,
                    label: 'Notes',
                    value: order.notes!,
                    context: context,
                    maxLines: 2,
                  ),
                ],
              ],
            ),
          ),

          // Total price section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: context.appTheme.semiBold16.copyWith(
                    color: AppColors.deepGrey,
                  ),
                ),
                Text(
                  '${order.total} جم',
                  style: context.appTheme.bold24.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({
    required this.item,
    required this.context,
  });

  final dynamic item;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CustomNetworkImage(
            img: item.img,
            width: 50,
            height: 50,
            radius: 12,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.item,
                  style: this.context.appTheme.medium16.copyWith(
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                Text(
                  '${item.price} جم × ${item.qty}',
                  style: this.context.appTheme.regular14.copyWith(
                    color: AppColors.deepGrey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${item.totalPrice.toInt()} جم',
            style: this.context.appTheme.semiBold16.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.context,
    this.maxLines = 1,
  });

  final IconData icon;
  final String label;
  final String value;
  final BuildContext context;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: this.context.appTheme.regular12.copyWith(
                  color: AppColors.deepGrey,
                ),
              ),
              const Gap(2),
              Text(
                value,
                style: this.context.appTheme.medium14.copyWith(
                  color: AppColors.black,
                ),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
