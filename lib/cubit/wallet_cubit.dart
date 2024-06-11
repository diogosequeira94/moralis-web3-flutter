import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moralis_web3_flutter/data/wallet_provider.dart';
import 'package:web3dart/credentials.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit({required this.walletProvider}) : super(WalletInitial());

  final WalletProvider walletProvider;

  Future<void> createWallet() async {
    emit(WalletSetupInProgress());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final mnemonic = walletProvider.generateMnemonic();
      final privateKey = await walletProvider.getPrivateKey(mnemonic);
      final publicKey = walletProvider.getPublicKey(privateKey);

      emit(WalletSetupSuccess(
        mnemonic: mnemonic,
        privateKey: privateKey,
        ethereumAddress: publicKey,
      ));
    } catch (_) {
      emit(WalletSetupFailure());
    }
  }
}
