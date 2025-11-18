import 'package:flutter/material.dart';

import '../../../../core/enums/order_status_enum.dart';
import '../../../../core/utils/utils.dart';
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
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.blueGrey[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User ID: ${order.userId}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Service ID: ${order.serviceId}'),
            const SizedBox(height: 4),
            Text('Address: ${order.address}'),
            const SizedBox(height: 4),
            Text('Payment: ${order.paymentMethod}'),
            const SizedBox(height: 4),
            Text(
              'Total: \$${order.total}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Notes: ${order.notes ?? "No Notes"}'),
            const SizedBox(height: 8),
            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _statusColor(order.status),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                order.status.name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
