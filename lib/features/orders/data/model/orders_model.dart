import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../home/data/model/pricies_service_model.dart';

import '../../../../core/enums/order_status_enum.dart';

class OrdersModel {
  final String phoneNumberId;
  final String serviceId;
  final List<PriciesServiceModel> orders;
  final int total;
  final String paymentMethod;
  final String address;
  final String? notes;
  final DateTime createdAt;
  final OrderStatusEnum status;
  OrdersModel({
    required this.phoneNumberId,
    required this.serviceId,
    required this.orders,
    required this.total,
    required this.paymentMethod,
    required this.address,
    this.notes,
    DateTime? createdAt,
    this.status = OrderStatusEnum.pendding,
  }) : createdAt = createdAt ?? DateTime.now();

  OrdersModel copyWith({
    String? phoneNumberId,
    String? serviceId,
    List<PriciesServiceModel>? orders,
    int? total,
    String? paymentMethod,
    String? address,
    String? notes,
    OrderStatusEnum? status,
    DateTime? createdAt,
  }) {
    return OrdersModel(
      phoneNumberId: phoneNumberId ?? this.phoneNumberId,
      serviceId: serviceId ?? this.serviceId,
      orders: orders ?? this.orders,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      phoneNumberId: json['userId'],
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      serviceId: json['serviceId'],
      orders: List<PriciesServiceModel>.from(
        json['orders']?.map((x) => PriciesServiceModel.fromJson(x)),
      ),
      total: json['total'],
      paymentMethod: json['paymentMethod'],
      address: json['address'],
      notes: json['notes'],
      status: OrderStatusEnum.fromJson(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': phoneNumberId,
      'serviceId': serviceId,
      'orders': orders.map((x) => x.toJson()).toList(),
      'total': total,
      'paymentMethod': paymentMethod,
      'address': address,
      'notes': notes,
      'status': status.value,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return '''OrdersModel(userId: $phoneNumberId, serviceId: $serviceId, orders: $orders, total: $total, paymentMethod: $paymentMethod, address: $address, notes: $notes, status: $status)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrdersModel &&
        other.phoneNumberId == phoneNumberId &&
        other.serviceId == serviceId &&
        listEquals(other.orders, orders) &&
        other.total == total &&
        other.paymentMethod == paymentMethod &&
        other.address == address &&
        other.notes == notes &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return phoneNumberId.hashCode ^
        serviceId.hashCode ^
        orders.hashCode ^
        total.hashCode ^
        paymentMethod.hashCode ^
        address.hashCode ^
        notes.hashCode ^
        status.hashCode ^
        createdAt.hashCode;
  }
}

List<OrdersModel> dummyOrders = [
  OrdersModel(
    phoneNumberId: 'user1',
    serviceId: 'service1',
    orders: dummyPriciesServiceModel.sublist(0, 3), // أول 3 items
    total: dummyPriciesServiceModel
        .sublist(0, 3)
        .map((e) => e.totalPrice)
        .reduce((a, b) => a + b)
        .toInt(),
    paymentMethod: 'Cash',
    address: '123 Street, Cairo',
    createdAt: DateTime.now(),
    status: OrderStatusEnum.pendding,
  ),
  OrdersModel(
    phoneNumberId: 'user2',
    serviceId: 'service2',
    orders: dummyPriciesServiceModel.sublist(3, 6), // 3 items تانية
    total: dummyPriciesServiceModel
        .sublist(3, 6)
        .map((e) => e.totalPrice)
        .reduce((a, b) => a + b)
        .toInt(),
    paymentMethod: 'Visa',
    address: '456 Street, Giza',
    status: OrderStatusEnum.accepted,
  ),
  OrdersModel(
    phoneNumberId: 'user3',
    serviceId: 'service3',
    orders: dummyPriciesServiceModel.sublist(6, 9), // آخر 3 items
    total: dummyPriciesServiceModel
        .sublist(6, 9)
        .map((e) => e.totalPrice)
        .reduce((a, b) => a + b)
        .toInt(),
    paymentMethod: 'Cash',
    address: '789 Street, Alexandria',
    status: OrderStatusEnum.accepted,
  ),
];
