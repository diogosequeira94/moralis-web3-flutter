import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moralis_web3_flutter/data/wallet_information_repository.dart';
import 'package:web3dart/web3dart.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit(WalletRepository walletRepository)
      : _walletRepository = walletRepository,
        super(TransactionsInitial());

  final WalletRepository _walletRepository;

  void sendTransaction(
      String privateKey, String receiver, EtherAmount txValue) async {
    emit(TransactionInProgress());
    try {
      final result = await _walletRepository.sendTransaction(
          privateKey, receiver, txValue);
      emit(TransactionSuccess(transactionId: result));
    } catch (e) {
      emit(TransactionFailure(message: e.toString()));
    }
  }
}
