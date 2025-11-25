part of 'transcation_cubit.dart';

sealed class TranscationState extends Equatable {
  const TranscationState();

  @override
  List<Object> get props => [];
}

final class TranscationInitial extends TranscationState {}

final class TranscationLoading extends TranscationState {}

final class TranscationLoaded extends TranscationState {
  final List<TransactionModel> transactions;
  const TranscationLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

final class TranscationError extends TranscationState {
  final String errMessage;
  const TranscationError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class WalletBalanceLoading extends TranscationState {}

final class WalletBalanceLoaded extends TranscationState {
  final num walletBalance;
  const WalletBalanceLoaded({required this.walletBalance});

  @override
  List<Object> get props => [walletBalance];
}

final class WalletBalanceError extends TranscationState {
  final String errMessage;
  const WalletBalanceError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class MakePaymentLoading extends TranscationState {}

final class MakePaymentLoaded extends TranscationState {
  const MakePaymentLoaded();

  @override
  List<Object> get props => [];
}

final class MakePaymentError extends TranscationState {
  final String errMessage;
  const MakePaymentError({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
