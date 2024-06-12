part of 'transactions_cubit.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();
}

class TransactionsInitial extends TransactionsState {
  @override
  List<Object> get props => [];
}

class TransactionInProgress extends TransactionsState {
  @override
  List<Object> get props => [];
}

class TransactionSuccess extends TransactionsState {
  final String transactionId;

  const TransactionSuccess({required this.transactionId});
  @override
  List<Object> get props => [transactionId];
}

class TransactionFailure extends TransactionsState {
  final String message;

  const TransactionFailure({required this.message});
  @override
  List<Object> get props => [message];
}
