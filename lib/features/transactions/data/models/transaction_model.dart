import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String userId;
  final String type;
  final String description;
  final num amount;
  final DateTime date;

  const TransactionModel({
    required this.userId,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      userId: json['userId'],
      type: json['type'],
      amount: json['amount'],
      date: (json['date'] as Timestamp).toDate(),
      description: json['description'],
    );
  }
}
