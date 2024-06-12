import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moralis_web3_flutter/data/wallet_provider.dart';
import 'package:web3dart/web3dart.dart';

part 'wallet_information_state.dart';

class WalletInformationCubit extends Cubit<WalletInformationState> {
  WalletInformationCubit({required WalletProvider walletProvider})
      : _walletProvider = walletProvider,
        super(WalletInformationInitial());

  final WalletProvider _walletProvider;

  Future<void> loadWalletInformation() async {
    emit(WalletInformationInProgress());
    try {
      final ethereumAddress = await _walletProvider.getAddressFromStorage();
      emit(WalletInformationLoaded(ethereumAddress));
    } catch (_) {
      emit(WalletInformationError());
    }
  }

  void onLogoutPressed() {
    _walletProvider.performLogout();
    emit(WalletLogoutSuccess());
  }
}
