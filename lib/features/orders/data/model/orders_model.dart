import 'package:flutter/foundation.dart';

import '../../../home/data/model/pricies_service_model.dart';

import '../../../../core/enums/order_status_enum.dart';

class OrdersModel {
  final String userId;
  final String serviceId;
  final List<PriciesServiceModel> orders;
  final int total;
  final String paymentMethod;
  final String address;
  final String? notes;
  final OrderStatusEnum status;
  const OrdersModel({
    required this.userId,
    required this.serviceId,
    required this.orders,
    required this.total,
    required this.paymentMethod,
    required this.address,
    this.notes,
    this.status = OrderStatusEnum.pendding,
  });


  OrdersModel copyWith({
    String? userId,
    String? serviceId,
    List<PriciesServiceModel>? orders,
    int? total,
    String? paymentMethod,
    String? address,
    String? notes,
    OrderStatusEnum? status,
  }) {
    return OrdersModel(
      userId: userId ?? this.userId,
      serviceId: serviceId ?? this.serviceId,
      orders: orders ?? this.orders,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      userId: json['userId'],
      serviceId: json['serviceId'],
      orders: List<PriciesServiceModel>.from(json['orders']?.map((x) => PriciesServiceModel.fromJson(x))),
      total: json['total'],
      paymentMethod: json['paymentMethod'],
      address: json['address'],
      notes: json['notes'],
      status: OrderStatusEnum.fromJson(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'serviceId': serviceId,
      'orders': orders.map((x) => x.toJson()).toList(),
      'total': total,
      'paymentMethod': paymentMethod,
      'address': address,
      'notes': notes,
      'status': status.value,
    };
  }

  @override
  String toString() {
    return '''OrdersModel(userId: $userId, serviceId: $serviceId, orders: $orders, total: $total, paymentMethod: $paymentMethod, address: $address, notes: $notes, status: $status)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrdersModel &&
      other.userId == userId &&
      other.serviceId == serviceId &&
      listEquals(other.orders, orders) &&
      other.total == total &&
      other.paymentMethod == paymentMethod &&
      other.address == address &&
      other.notes == notes &&
      other.status == status;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      serviceId.hashCode ^
      orders.hashCode ^
      total.hashCode ^
      paymentMethod.hashCode ^
      address.hashCode ^
      notes.hashCode ^
      status.hashCode;
  }
}
