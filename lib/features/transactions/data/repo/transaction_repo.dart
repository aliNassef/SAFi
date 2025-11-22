import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/transaction_model.dart';

abstract class TransactionRepo {
  Future<Either<Failure, List<TransactionModel>>> getTransactions(String userId, [int? limit]);
}
