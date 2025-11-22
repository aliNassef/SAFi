import 'package:safi/core/services/firebase_firestore_service.dart';

import '../models/transaction_model.dart';

abstract class TransactionsRemoteDataSource {
  Future<List<TransactionModel>> getTransactions(String userId, [int? limit]);
  Future<num> getUserWalletBalance(String userId);
}

class TransactionsRemoteDataSourceImpl implements TransactionsRemoteDataSource {
  final FirebaseStoreService _service;

  TransactionsRemoteDataSourceImpl({required FirebaseStoreService service})
    : _service = service;

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
}
