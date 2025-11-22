import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safi/features/transactions/data/models/transaction_model.dart';
import 'package:safi/features/transactions/data/repo/transaction_repo.dart';

part 'transcation_state.dart';

class TranscationCubit extends Cubit<TranscationState> {
  TranscationCubit(this._transactionRepo) : super(TranscationInitial());
  final TransactionRepo _transactionRepo;

  void getTransactions(String userId, [int? limit]) async {
    emit(TranscationLoading());
    final transactionsOrfailure = await _transactionRepo.getTransactions(
      userId,
      limit,
    );
    transactionsOrfailure.fold(
      (failure) => emit(TranscationError(errMessage: failure.errMessage)),
      (transactions) => emit(TranscationLoaded(transactions: transactions)),
    );
  }
}
