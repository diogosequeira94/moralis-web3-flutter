import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moralis_web3_flutter/data/storage/wallet_local_storage.dart';

part 'wallet_information_state.dart';

class WalletInformationCubit extends Cubit<WalletInformationState> {
  WalletInformationCubit({required WalletLocalStorage walletLocalStorage})
      : _walletLocalStorage = walletLocalStorage,
        super(WalletInformationInitial());

  final WalletLocalStorage _walletLocalStorage;
}
