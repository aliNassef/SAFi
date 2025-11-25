import 'package:safi/core/services/firebase_firestore_service.dart';

import '../../../../core/services/stripe_service.dart';
import '../models/transaction_model.dart';

abstract class TransactionsRemoteDataSource {
  Future<List<TransactionModel>> getTransactions(String userId, [int? limit]);
  Future<num> getUserWalletBalance(String userId);
  Future<void> makePayment(String userId, String amount, String currency);
}

class TransactionsRemoteDataSourceImpl implements TransactionsRemoteDataSource {
  final FirebaseStoreService _service;
  final StripeService _stripeService;

  TransactionsRemoteDataSourceImpl({
    required FirebaseStoreService service,
    required StripeService stripeService,
  }) : _service = service,
       _stripeService = stripeService;

  @override
  Future<List<TransactionModel>> getTransactions(
    String userId, [
    int? limit,
  ]) async {
    final response = await _service.getUserTransactions(userId, limit);
    return response.docs
        .map((e) => TransactionModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<num> getUserWalletBalance(String userId) async {
    final response = await _service.getUser(userId);
    final data = response.data() as Map<String, dynamic>;
    return data['walletBalance'];
  }

  @override
  Future<void> makePayment(
    String userId,
    String amount,
    String currency,
  ) async {
    // Call Stripe service to process payment
    final success = await _stripeService.makePayment(
      amount: amount,
      currency: currency,
    );

    if (!success) {
      throw Exception('Payment failed');
    }

    // If payment successful, increment wallet balance
    await _service.incrementWalletBalance(
      userId,
      double.parse(amount),
    );
  }
}
