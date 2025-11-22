import 'package:dartz/dartz.dart';
import 'package:safi/core/errors/failure.dart';
import 'package:safi/features/transactions/data/datasource/transactions_remote_datasource.dart';
import 'package:safi/features/transactions/data/models/transaction_model.dart';
import 'package:safi/features/transactions/data/repo/transaction_repo.dart';

class TransactionRepoImpl implements TransactionRepo {
  final TransactionsRemoteDataSource _remoteDataSource;

  TransactionRepoImpl({required TransactionsRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions(
    String userId, [
    int? limit,
  ]) async {
    try {
      final transactions = await _remoteDataSource.getTransactions(
        userId,
        limit,
      );
      return Right(transactions);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
