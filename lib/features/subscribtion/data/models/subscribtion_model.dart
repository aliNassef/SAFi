import 'package:flutter/foundation.dart';

class SubscribtionModel {
  final String name;
  final num price;
  final List<String> advantages;
  final String? id;
  final int? washesInclude;
  final int washesUsed;

  const SubscribtionModel({
    required this.name,
    required this.price,
    required this.advantages,
    this.id,
    this.washesInclude,
    this.washesUsed = 0,
  });

  SubscribtionModel copyWith({
    String? name,
    num? price,
    List<String>? advantages,
  }) {
    return SubscribtionModel(
      name: name ?? this.name,
      price: price ?? this.price,
      advantages: advantages ?? this.advantages,
      id: id,
      washesUsed: washesUsed,
      washesInclude: washesInclude,
    );
  }

  factory SubscribtionModel.fromJson(Map<String, dynamic> json) {
    return SubscribtionModel(
      name: json['name'],
      price: json['price'],
      advantages: List<String>.from(json['advantages']),
      id: json['id'],
      washesUsed: json['washesUsed'] ?? 0,
      washesInclude: json['washesIncluded'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'advantages': advantages,
      'id': id,
      'washesUsed': washesUsed,
      'washesInclude': washesInclude,
    };
  }

  @override
  String toString() =>
      '''SubscribtionModel(name: $name, price: $price, advantages: $advantages)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubscribtionModel &&
        other.name == name &&
        other.price == price &&
        listEquals(other.advantages, advantages) &&
        other.washesInclude == washesInclude &&
        other.washesUsed == washesUsed;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      price.hashCode ^
      advantages.hashCode ^
      washesUsed.hashCode ^
      washesInclude.hashCode;
}

final List<SubscribtionModel> dummySubscriptions = [
  const SubscribtionModel(
    name: 'Basic',
    price: 9.99,
    advantages: ['Access to basic features', 'Email support'],
  ),
  const SubscribtionModel(
    name: 'Standard',
    price: 19.99,
    advantages: ['Everything in Basic', 'Priority support', 'Extra storage'],
  ),
  const SubscribtionModel(
    name: 'Premium',
    price: 29.99,
    advantages: [
      'Everything in Standard',
      'Dedicated account manager',
      'Unlimited storage',
    ],
  ),
  const SubscribtionModel(
    name: 'Enterprise',
    price: 49.99,
    advantages: [
      'Everything in Premium',
      'Custom integrations',
      '24/7 support',
    ],
  ),
];
